library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Specification
--Write a design that implements a shift register and the following behaviour by applying a FSM design method:

--The register contents can be loaded (LOAD operation) via a parallel data input (d_i)
--The register content can be shifted (SHIFT operation) to a serial output (ser_o)
--The register content is connected to a parallel data output (q_o)
--The LOAD operation is executed when no SHIFT operation is active and the en_i control input is set to '1' and the sh_i control input is set to '0'
--The SHIFT operation is started when en_i = '1' and sh_i = '1'
--The SHIFT operation shifts the contents of the shift register to the left
--The SHIFT operation finishes after all bits of the shift register have been shifted out on the serial line (ser_o)
--The SHIFT operation shifts one bit per clock cycle
--For each shift a '0' is shifted into the shift register from the right side

entity shiftRegister is
	port(	d_i : in std_logic_vector(7 downto 0);
		q_o : out std_logic_vector(7 downto 0);
		ser_o : out std_logic; 
		en_i : in std_logic;
		sh_i : in  std_logic 
		clk_i:   in  std_logic;
		reset: in std_logic;
	);
		
end shiftRegister;

architecture rtl of shiftRegister is
	type t_state is (IDLE, LOAD, STEP1,STEP2,STEP3,STEP4,STEP5,STEP6,STEP7,STEP8);
	signal s_presentstate : t_state;   
	signal s_nextstate : t_state; 
	
begin
	next_state: process(clk_i,reset,en_i, sh_i)
	begin
		if reset_i = '1' then 
			 s_presentstate <= IDLE; 
		elsif rising_edge(clk) then 
			if en_i = '1' and sh_i = '1' then
			 	s_presentstate <= s_nextstate;
			elsif  en_i = '1' and sh_i = '1' and s_presentstate = IDLE then
				s_presentstate <= LOAD;
			end if;	
		end if;
	end process;

	control_process: process(en_i, sh_i)
	begin
		case s_presentstate is 
			when
		end case;
	end process;
end rtl;
