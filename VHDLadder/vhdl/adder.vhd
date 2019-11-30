library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder is
	port(	data_i0 : in std_logic_vector(7 downto 0);
		data_i1 : in std_logic_vector(7 downto 0);
		data_o : out std_logic_vector(8 downto 0));
		
end adder;

architecture rtl of adder is
	signal input0 : natural range 0 to 255;
	signal input1 : natural range 0 to 255;
	signal outPut: natural range 0 to 510;
	
begin
	input0 <= to_integer(unsigned(data_i0));
	input1 <= to_integer(unsigned(data_i1));
	

	process(input0 , input1)
	begin
		outPut <= input0 + input1;
		data_o <=STD_LOGIC_VECTOR(TO_UNSIGNED(outPut,9));
	end process;

end rtl;
