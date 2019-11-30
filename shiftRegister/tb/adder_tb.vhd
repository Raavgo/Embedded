-------------------------------------------------------------------------------
-- Design: VHDL Class Example 3 : decoder design testbench                   --
--                                                                           --
-- Author : Roland Hoeller, Andreas Puhm                                     --
-- Date   : 27 04 2000                                                       --
-- File   : tb_decoder.vhd                                                   --
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder_tb is end adder_tb;

architecture sim of adder_tb is

  -- Declaration of the component under test
  component adder
	port(data_i0 : in std_logic_vector(7 downto 0);
		data_i1 : in std_logic_vector(7 downto 0);
		data_o : out std_logic_vector(8 downto 0));
  end component;

  	signal data_i0 : std_logic_vector(7 downto 0);
	signal data_i1 :  std_logic_vector(7 downto 0);
	signal data_o :  std_logic_vector(8 downto 0);
	signal input0 : natural range 0 to 255;
	signal input1 : natural range 0 to 255;
	signal outPut: natural range 0 to 510;

begin

  -- Instantiate the design under test
  i_decoder : adder
    port map (
      data_i0 => data_i0,
	  data_i1 => data_i1,
      data_o => data_o);

  -- Generate inputs for simulation
  run : process
  begin
    data_i0 <= "11100001";
	data_i1 <= "01100001";
    wait for 100 ns;                    -- expected: data_o(0) = 1, others '0'
    data_i0 <= "01100001";
	data_i1 <= "00011100";
    wait for 100 ns;                    -- expected: data_o(1) = 1, others '0'
    data_i0 <= "00011100";
	data_i1 <= "00001111";
    wait for 100 ns;                    -- expected: data_o(2) = 1, others '0'
    data_i0 <= "00001111";
	data_i1 <= "11100011";
    wait for 100 ns;                    -- expected: data_o(3) = 1, others '0'
    data_i0 <= "01010101";
	data_i1 <= "01100001";
    wait for 100 ns;                    -- expected: data_o(4) = 1, others '0'
    data_i0 <= "11111111";
	data_i1 <= "11111111";
    wait for 100 ns;                    -- expected: data_o(5) = 1, others '0'
    data_i0 <= "00000000";
	data_i1 <= "01100001";
    wait for 100 ns;                    -- expected: data_o(6) = 1, others '0'
    data_i0 <= "10111000";
	data_i1 <= "00011111";
    wait for 100 ns;                    -- expected: data_o(7) = 1, others '0'
  end process run;

end sim;