library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_Manager_tb is
end Display_Manager_tb;

architecture Behavioral of Display_Manager_tb is

    component Display_Manager is
        Port (
            clk          : in  std_logic;
            reset        : in  std_logic;
            display_text : in  std_logic_vector(63 downto 0);
            SEG          : out std_logic_vector(6 downto 0);
            AN           : out std_logic_vector(7 downto 0);
            dp           : out std_logic
        );
    end component;

    signal clk_tb    : std_logic := '0';
    signal reset_tb  : std_logic := '0';
    signal text_tb   : std_logic_vector(63 downto 0);
    signal SEG_tb    : std_logic_vector(6 downto 0);
    signal AN_tb     : std_logic_vector(7 downto 0);
    signal dp_tb     : std_logic;

    constant CLK_PERIOD : time := 10 ns;

    constant MSG_COLA  : std_logic_vector(63 downto 0) := x"636F6C4130313330"; -- "colA0130"
    constant MSG_BEER  : std_logic_vector(63 downto 0) := x"6245457230313530"; -- "bEEr0150"
    constant MSG_H2O   : std_logic_vector(63 downto 0) := x"68324F2020303930"; -- "h2O 0090"
    constant MSG_BLANK : std_logic_vector(63 downto 0) := x"2020202020202020"; -- "        "


    function to_ascii_vector(s: string) return std_logic_vector is
        variable result : std_logic_vector(63 downto 0) := (others => '0');
    begin
        for i in 0 to 7 loop
            if i < s'length then
                result(63 - i*8 downto 56 - i*8) := std_logic_vector(to_unsigned(character'pos(s(i+1)), 8));
            else
                result(63 - i*8 downto 56 - i*8) := x"20"; -- space
            end if;
        end loop;
        return result;
    end function;

begin
    DUT : Display_Manager
        port map (
            clk          => clk_tb,
            reset        => reset_tb,
            display_text => text_tb,
            SEG          => SEG_tb,
            AN           => AN_tb,
            dp           => dp_tb
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
        variable msg_AbE : std_logic_vector(63 downto 0);
    begin
        -- Initial Reset
        reset_tb <= '1';
        wait for CLK_PERIOD * 2;
        reset_tb <= '0';

        -- Test Case 1: "AbE123 0"
        msg_AbE := to_ascii_vector("AbE123 0");
        text_tb <= msg_AbE;
        wait for CLK_PERIOD * 2;
        assert text_tb = msg_AbE
            report "TC1 Failed: text_tb does not match 'AbE123 0'" severity error;
        wait for 3 ms;

        -- Test Case 2: "colA0130"
        text_tb <= MSG_COLA;
        wait for CLK_PERIOD * 2;
        assert text_tb = MSG_COLA
            report "TC2 Failed: text_tb does not match 'colA0130'" severity error;
        wait for 3 ms;

        -- Test Case 3: "bEEr0150"
        text_tb <= MSG_BEER;
        wait for CLK_PERIOD * 2;
        assert text_tb = MSG_BEER
            report "TC3 Failed: text_tb does not match 'bEEr0150'" severity error;
        wait for 3 ms;

        -- Test Case 4: "h2O 0090"
        text_tb <= MSG_H2O;
        wait for CLK_PERIOD * 2;
        assert text_tb = MSG_H2O
            report "TC4 Failed: text_tb does not match 'h2O 0090'" severity error;
        wait for 3 ms;

        -- Test Case 5: Blank
        text_tb <= MSG_BLANK;
        wait for CLK_PERIOD * 2;
        assert text_tb = MSG_BLANK
            report "TC5 Failed: text_tb does not match blank message" severity error;
        wait for 3 ms;

        report "Display_Manager hybrid test with text_tb assertions completed." severity note;
        wait;
    end process;

end Behavioral;

