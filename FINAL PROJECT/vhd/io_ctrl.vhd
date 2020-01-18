-------------------------------------------------------------------------------
-- --
-- XXXXXXXX X X XXXXXXXXX X X XXXXXXX XXXXXXX --
-- X X X X X X X X X --
-- X X X X X X X X X --
-- X X X X X X X X X --
-- XXXXXXX XXXXXXXX X X X XXXX XXXXXXX X X --
-- X X X X X X X X X X --
-- X X X X X X X X X X X --
-- X X X X X X X X X X X --
-- X X X X X X XXXXXXX XXXXXXX --
-- --
-- F A C H H O C H S C H U L E - T E C H N I K U M W I E N --
-- --
-- Embedded Systems Division --
-- --
-------------------------------------------------------------------------------
-- --
-- Web: http://www.technikum-wien.at/ --
-- --
-- Contact: hoeller@technikum-wien.at --
-- --
-------------------------------------------------------------------------------
--
--
-- Author: Roland Höller
--
-- Filename: io_ctrl_.vhd
--
-- Date of Creation: Sun Oct 20 12:14:48 2002
--
-- Version: $Revision$
--
-- Date of Latest Version: $Date$
--
-- Design Unit: IO Control Unit (Entity)
--
-- Description: Manages the interface to the 7-segment displays,
-- the push buttons and the switches.
--
--
-------------------------------------------------------------------------------
--
-- CVS Change Log:
--
-- $Log$
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.ALL;

entity io_ctrl is

port (
	clk_i : in std_logic; -- 100 MHz system clock
	reset_i : in std_logic; -- asynchronous reset
    	cntr0_i : in STD_LOGIC_VECTOR(7 downto 0);
	cntr1_i : in STD_LOGIC_VECTOR(7 downto 0);
	cntr2_i : in STD_LOGIC_VECTOR(7 downto 0);
	cntr3_i : in STD_LOGIC_VECTOR(7 downto 0);
	sw_i : in STD_LOGIC_VECTOR(15 downto 0);
	pb_i : in STD_LOGIC_VECTOR(3 downto 0);
	
	ss_o : out STD_LOGIC_VECTOR(7 downto 0); --siebensegment HW FPGA
	ss_sel_o : out STD_LOGIC_VECTOR(3 downto 0); --select the right segment
	swclean_o: out STD_LOGIC_VECTOR(15 downto 0); -- entprellte Switches
	pbclean_o: out STD_LOGIC_VECTOR(3 downto 0) -- entprellte Switches
);
end io_ctrl;

architecture rtl of io_ctrl is
 signal s_1khzen : std_logic:= '0';
 signal swsync_o : std_logic_vector(15 downto 0):="0000000000000000";
 signal pbsync_o : std_logic_vector(3 downto 0 ):= "0000";
 signal s_ss_sel : std_logic_vector(3 downto 0 );
 signal s_ss : std_logic_vector(7 downto 0);
 
 signal debounceCounter : integer := 0;
 signal displayCounter : integer := 0;
 signal clkCounter : integer :=0;
 signal changed : integer := 0;
 signal tempVector : std_logic_vector(15 downto 0);

begin -- rtl

 -----------------------------------------------------------------------------
 --
 -- Generate 1 KHz enable signal.
 --
 -----------------------------------------------------------------------------
 
 p_slowen: process (clk_i, reset_i)
 begin -- process p_slowen
 if reset_i = '1' then
	clkCounter <= 1;
	s_1khzen <= '0';
 elsif clk_i'event and clk_i = '1' then -- rising clock edge
    	clkCounter <=clkCounter+1;
	if (clkCounter = 50000) then --fuer 1khz 10^-3/10^-8/2
		s_1khzen <= NOT s_1khzen;
		clkCounter <= 1;
	end if;	
 end if;
 end process p_slowen;

 -----------------------------------------------------------------------------
 --
 -- Debounce buttons and switches
 --
 -----------------------------------------------------------------------------
 
 p_debounce: process (reset_i,s_1khzen)
 begin -- process debounce
 if reset_i = '1' then -- asynchronous reset (active high)
 elsif (s_1khzen'event and s_1khzen = '1') then
	changed <= to_integer(signed(swsync_o xor sw_i)) +  to_integer(signed(pbsync_o xor pb_i));

	if (changed > 0) then 
		if (debounceCounter < 20) then
			debounceCounter <= debounceCounter + 1;
		elsif (debounceCounter = 20) then
			swsync_o <= sw_i;
			pbsync_o <= pb_i;
			debounceCounter <= 0;
		end if;
	end if;
 end if;
 end process p_debounce;
 
 swclean_o <= swsync_o;
 pbclean_o <= pbsync_o;


 -----------------------------------------------------------------------------
 --
 -- Display controller for the 7-segment display
 --
 -----------------------------------------------------------------------------
 
 p_displaycontrol: process (s_1khzen, reset_i)
 begin -- process displaycontrol
 if reset_i = '1' then
	displayCounter <= 0;
 elsif s_1khzen'event and s_1khzen = '1' then -- rising clock edge
	case displayCounter is
		when 0 => 
			s_ss <= cntr0_i;
			s_ss_sel <= "1110";
			displayCounter <= displayCounter +1;
		when 1 => 
			s_ss <= cntr1_i;
			s_ss_sel <= "1101";
			displayCounter <= displayCounter +1;
		when 2 => 
			s_ss <= cntr2_i;
			s_ss_sel <= "1011";
			displayCounter <= displayCounter +1;
		when 3 => 
			s_ss <= cntr3_i;
			s_ss_sel <= "0111";
			displayCounter <= 0;
		
		when others => 
			displayCounter <=0;
	end case;
	
 end if;
 end process p_displaycontrol;
 ss_o <= s_ss;
 ss_sel_o <= s_ss_sel;
end rtl;