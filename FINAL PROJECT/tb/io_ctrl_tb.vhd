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
entity io_ctrl_tb is

end entity;

 
--The architecture of the IO control unit is held in a separate file:
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
-- Filename: io_ctrl_rtl.vhd
--
-- Date of Creation: Sun Oct 20 12:16:48 2002
--
-- Version: $Revision$
--
-- Date of Latest Version: $Date$
--
-- Design Unit: IO Control Unit (Architecture)
--
--Entity of the io_ctrl unit. The ports
--clk_i, reset_i, ss_o, ss_sel_o, sw_i and
--pb_i are IOs of the FPGA. All other
--signals reside inside the FPGA and are
--connected to the counter unit.
--7
--Every 1 ms, this signal
--will be set to a logic ‘1’
--for a single 100 MHz
--clock period.
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
use ieee.std_logic_arith.all;
architecture sim of io_ctrl_tb is
component io_ctrl
port (
		clk_i : in std_logic; -- 100 MHz system clock
		reset_i : in std_logic; -- asynchronous reset
	    
		cntr0_i : in STD_LOGIC_VECTOR(6 downto 0);
		cntr1_i : in STD_LOGIC_VECTOR(6 downto 0);
		cntr2_i : in STD_LOGIC_VECTOR(6 downto 0);
		cntr3_i : in STD_LOGIC_VECTOR(6 downto 0);
		
		sw_i : in STD_LOGIC_VECTOR(15 downto 0);
		pb_i : in STD_LOGIC_VECTOR(3 downto 0);
		
		ss_o : out STD_LOGIC_VECTOR(6 downto 0); --siebensegment HW FPGA
		ss_sel_o : out STD_LOGIC_VECTOR(3 downto 0); --select the right segment
		swclean_o: out STD_LOGIC_VECTOR(15 downto 0); -- entprellte Switches
		pbclean_o: out STD_LOGIC_VECTOR(3 downto 0) -- entprellte Switches
);
end component;
 --constant C_ENCOUNTVAL : std_logic_vector(16 downto 0):= "10010101111000000";
 signal clk_s : STD_LOGIC := '0';
 signal reset_s : STD_LOGIC; -- reset
 
 signal cntr0_s : STD_LOGIC_VECTOR(6 downto 0);
 signal cntr1_s : STD_LOGIC_VECTOR(6 downto 0);
 signal cntr2_s : STD_LOGIC_VECTOR(6 downto 0);
 signal cntr3_s : STD_LOGIC_VECTOR(6 downto 0);

signal sw_s : STD_LOGIC_VECTOR(15 downto 0);
signal pb_s : STD_LOGIC_VECTOR(3 downto 0);
signal ss_s : STD_LOGIC_VECTOR(6 downto 0);
signal ss_sel_s : STD_LOGIC_VECTOR(3 downto 0);
signal swclean_s : STD_LOGIC_VECTOR(15 downto 0);
signal pbclean_s : STD_LOGIC_VECTOR(3 downto 0);

begin -- rtl
	uut : io_ctrl
	port map(
		clk_i => clk_s,
		reset_i => reset_s,
	    
		cntr0_i => cntr0_s,
		cntr1_i => cntr1_s,
		cntr2_i => cntr2_s,
		cntr3_i => cntr3_s,
		
		sw_i => sw_s,   
		pb_i => pb_s,
		
		ss_o  => ss_s,
		ss_sel_o => ss_sel_s,
		swclean_o => swclean_s,
		pbclean_o => pbclean_s
);
 clk_s <= not clk_s after 10 ns;
 p_test : process
 begin
	reset_s <= '0';
	cntr0_s <= "0110010"; 
	cntr1_s <= "1000011"; 
	cntr2_s <= "0001000"; 
	cntr3_s <= "0000101"; 

	sw_s <= "0000000000000000";
	pb_s <= "0101";
 	wait for 100 ms;
	sw_s <= "0100000000000000";
	wait for 2 ms;
	sw_s <= "0000000000000000";
	wait for 1 ms;
	sw_s <= "0100000000000000";
	wait for 2 ms;
	sw_s <= "0000000000000000";
	wait for 1 ms;
	sw_s <= "0100000000000000";
	wait;

 end process;
end sim;