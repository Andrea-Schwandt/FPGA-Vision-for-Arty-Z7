-- lane_sync.vhd
--
-- delay video sync signals
--
-- FPGA Vision Remote Lab http://h-brs.de/fpga-vision-lab
-- (c) Marco Winzker, Hochschule Bonn-Rhein-Sieg, 03.01.2018
--
-- 22.05.2020 - Marco Winzker - assignment of input signals now inside process to avoid simulation problem, minimum delay is 2
-- 19.08.2026 - Andrea Schwandt - added adjustment of vertical sync and delay of unfiltered signal

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity lane_sync is
  generic (delay : integer := 6;
			  line_delay : integer := 1);
  port (clk    : in  std_logic;
        reset  : in  std_logic;
        vs_in  : in  std_logic;
        hs_in  : in  std_logic;
        de_in  : in  std_logic;
        vs_out : out std_logic;
        hs_out : out std_logic;
        de_out : out std_logic;
        data_in  : in  std_logic_vector(23 downto 0);
        data_out : out std_logic_vector(23 downto 0));
end lane_sync;

architecture behave of lane_sync is

  constant line_pix  : integer := 1650;

  type delay_array is array (1 to (delay + line_delay*line_pix)) of std_logic;
  signal vs_delay : delay_array;
  signal hs_delay : delay_array;
  signal de_delay : delay_array;
  
  type delay_array_pix is array (1 to (delay + line_delay*line_pix)) of std_logic_vector(23 downto 0);
  signal data_delay: delay_array_pix;
  

begin

  process
  begin
    wait until rising_edge(clk);

     -- first value of array is current input
     vs_delay(1) <= vs_in;
     hs_delay(1) <= hs_in;
     de_delay(1) <= de_in;
	  data_delay(1) <= data_in;

    -- delay according to generic
    for i in 2 to (delay + line_delay*line_pix) loop
      vs_delay(i) <= vs_delay(i-1);
      hs_delay(i) <= hs_delay(i-1);
      de_delay(i) <= de_delay(i-1);
    end loop;
	 for i in 2 to  (delay + line_delay*line_pix) loop
      data_delay(i) <= data_delay(i-1);
    end loop;

  end process;

  -- last value of array is output
  vs_out <= vs_delay(delay + line_delay*line_pix);
  hs_out <= hs_delay(delay + line_delay*line_pix);
  de_out <= de_delay(delay + line_delay*line_pix);
  data_out <= data_delay(delay + line_delay*line_pix);

end behave;
