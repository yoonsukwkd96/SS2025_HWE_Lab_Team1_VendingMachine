library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_Controller_tb is
end FSM_Controller_tb;

architecture Behavioral of FSM_Controller_tb is

    component FSM_Controller is
        Port (
            clk             : in  std_logic;
            reset           : in  std_logic;
            BTNC            : in  std_logic;
            SW              : in  std_logic_vector(2 downto 0);
            inserted_amount : in  unsigned(13 downto 0);
            LED             : out std_logic_vector(3 downto 0);
            display_text    : out std_logic_vector(63 downto 0)
        );
    end component;

    signal clk_tb             : std_logic := '0';
    signal reset_tb           : std_logic := '0';
    signal BTNC_tb            : std_logic := '0';
    signal SW_tb              : std_logic_vector(2 downto 0) := (others => '0');
    signal inserted_amount_tb : unsigned(13 downto 0) := (others => '0');
    signal LED_tb             : std_logic_vector(3 downto 0);
    signal display_text_tb    : std_logic_vector(63 downto 0);

    constant CLK_PERIOD : time := 10 ns;

    function to_string(vec : std_logic_vector) return string is
        variable s : string(1 to vec'length/8);
    begin
        for i in 0 to s'length - 1 loop
            s(i+1) := character'val(to_integer(unsigned(vec(63 - i*8 downto 56 - i*8))));
        end loop;
        return s;
    end function;

begin

    DUT: FSM_Controller
        port map (
            clk             => clk_tb,
            reset           => reset_tb,
            BTNC            => BTNC_tb,
            SW              => SW_tb,
            inserted_amount => inserted_amount_tb,
            LED             => LED_tb,
            display_text    => display_text_tb
        );

    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc : process
    begin
        -- Initial Reset
        reset_tb <= '1'; wait for CLK_PERIOD * 2; reset_tb <= '0'; wait for CLK_PERIOD * 2;

        -- Test Case 1: IDLE -> DISPLAY
        BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;

        -- Test Case 2: DISPLAY (invalid switch: SW = "000")
        SW_tb <= "000"; BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
        assert LED_tb = "0010" report "Unexpected state transition on invalid switch" severity error;

        -- Test Case 3: DISPLAY -> INSERT (valid switch: SW = "001")
        SW_tb <= "001"; BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
        assert LED_tb = "0100" report "Failed to transition to INSERT" severity error;

        -- Test Case 4: INSERT (not enough money)
        inserted_amount_tb <= to_unsigned(50, 14); BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
        assert LED_tb = "0100" report "Should not transition with insufficient money" severity error;

        -- Test Case 5: INSERT -> DISPENSE
        inserted_amount_tb <= to_unsigned(130, 14); BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
        assert LED_tb = "1000" report "Failed to transition to DISPENSE" severity error;

        -- Test Case 6: DISPENSE (invalid: switch still ON)
        SW_tb <= "001"; BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
        assert LED_tb = "1000" report "Should not transition when switch ON" severity error;

        -- Test Case 7: DISPENSE -> IDLE (switch OFF)
        SW_tb <= "000"; BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
        assert LED_tb = "0001" report "Failed to transition to IDLE" severity error;

        -- DISPLAY content verification
	-- Test Case 8: IDLE to DISPLAY (BTNC pressed) 
        BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5; 

	--  Test Case 9: display item 1 verification
        SW_tb <= "001"; wait for CLK_PERIOD * 2;
        assert to_string(display_text_tb) = "colA0130" report "Wrong DISPLAY text for SW=001" severity error;
        
	--  Test Case 10: display item 2 verification
	SW_tb <= "010"; wait for CLK_PERIOD * 2;
        assert to_string(display_text_tb) = "bEEr0150" report "Wrong DISPLAY text for SW=010" severity error;
        
	-- Test Case 11: display item 3 verification
	SW_tb <= "100"; wait for CLK_PERIOD * 2;
        assert to_string(display_text_tb) = "h2o 0090" report "Wrong DISPLAY text for SW=100" severity error;

	-- INSERT content verification
        -- Test Case 12: DISPLAY to INSERT (BTNC pressed), insert item 3 display verification and insert coin display verification
        BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5; 
        inserted_amount_tb <= to_unsigned(50, 14); wait for CLK_PERIOD * 2;
        assert to_string(display_text_tb)(1 to 4) = "0090" report "Price incorrect in INSERT" severity error;
        assert to_string(display_text_tb)(5 to 8) = "0050" report "Inserted incorrect in INSERT" severity error;

        -- Test Case 13: In the state DISPENSE shows correct change, inserted coin is 150, change should be 60
        inserted_amount_tb <= to_unsigned(150, 14); BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
	assert LED_tb = "1000" report "State transition to DISPENSE was not successful" severity error;
        assert to_string(display_text_tb)(1 to 4) = "chgE" report "Missing chgE prefix" severity error;
        assert to_string(display_text_tb)(5 to 8) = "0060" report "Wrong change value" severity error;

        -- Test Case 14: Attempt to finish the entire vending machine simulaion with BTNC pressed with switch still ON
        BTNC_tb <= '1'; wait for CLK_PERIOD * 2; BTNC_tb <= '0'; wait for CLK_PERIOD * 2;
        assert LED_tb /= "0001" report "FSM transitioned to IDLE despite switch being ON" severity error;

        -- Test Case 15: Turn off switch and press BTNC to go to IDLE
        SW_tb <= "000"; BTNC_tb <= '1'; wait for CLK_PERIOD; BTNC_tb <= '0'; wait for CLK_PERIOD * 5;
        assert LED_tb = "0001" report "FSM did not transition to IDLE after switch off and BTNC" severity error;

        report "FSM_Controller full test completed successfully." severity note;
        wait;
    end process;

end Behavioral;

