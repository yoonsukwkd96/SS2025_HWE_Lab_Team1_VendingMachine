library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.types_pkg.all;

entity VendingMachine_Top is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        BTNC  : in  std_logic;
        BTNU  : in  std_logic;
        BTNL  : in  std_logic;
        BTNR  : in  std_logic;
        BTND  : in  std_logic;
        SW    : in  std_logic_vector(2 downto 0);
        LED   : out std_logic_vector(4 downto 0);
        SEG   : out std_logic_vector(6 downto 0);
        AN    : out std_logic_vector(7 downto 0);
        dp    : out std_logic
    );
end VendingMachine_Top;

architecture Structural of VendingMachine_Top is

    signal current_state : state_type;
    signal state_debug   : state_type;  -- 
    signal inserted_amt  : unsigned(7 downto 0);
    signal item_name     : display_array;
    signal item_price    : unsigned(7 downto 0);
    signal left_data     : std_logic_vector(15 downto 0):= (others => '0');
    signal right_data    : std_logic_vector(15 downto 0):= (others => '0');

begin

    ----------------------------------------------------------------
    -- FSM Controller
    ----------------------------------------------------------------
    U1: entity work.FSM_Controller
        port map (
            clk           => clk,
            reset         => reset,
            BTNC          => BTNC,
            SW            => SW,
            inserted      => inserted_amt,
            price_reg     => item_price,
            current_state => current_state,
            state_debug   => state_debug     
        );

    ----------------------------------------------------------------
    -- Coin Handler
    ----------------------------------------------------------------
    U2: entity work.Coin_Handler
        port map (
            clk           => clk,
            reset         => reset,
            current_state => current_state,
            BTNU          => BTNU,
            BTNL          => BTNL,
            BTNR          => BTNR,
            BTND          => BTND,
            inserted      => inserted_amt
        );

    ----------------------------------------------------------------
    -- Item ROM
    ----------------------------------------------------------------
    U3: entity work.Item_ROM
        port map (
            SW         => SW,
            item_name  => item_name,
            item_price => item_price
        );

    ----------------------------------------------------------------
    -- Display Logic
    ----------------------------------------------------------------
    process(current_state, item_name, item_price, inserted_amt)
        variable hundreds, tens, ones : integer;
        variable display_right : std_logic_vector(15 downto 0);
    begin
        case current_state is
            when DISPLAY =>
                left_data <= item_name(3) & item_name(2) & item_name(1) & item_name(0);
                hundreds := to_integer(item_price) / 100;
                tens     := (to_integer(item_price) / 10) mod 10;
                ones     := to_integer(item_price) mod 10;
                display_right := (others => '0');
                display_right(11 downto 8) := std_logic_vector(to_unsigned(hundreds, 4));
                display_right(7 downto 4)  := std_logic_vector(to_unsigned(tens, 4));
                display_right(3 downto 0)  := std_logic_vector(to_unsigned(ones, 4));
                right_data <= display_right;

            when INSERT =>
                left_data <= (others => '1');
                hundreds := to_integer(item_price) / 100;
                tens     := (to_integer(item_price) / 10) mod 10;
                ones     := to_integer(item_price) mod 10;
                display_right := (others => '0');
                display_right(11 downto 8) := std_logic_vector(to_unsigned(hundreds, 4));
                display_right(7 downto 4)  := std_logic_vector(to_unsigned(tens, 4));
                display_right(3 downto 0)  := std_logic_vector(to_unsigned(ones, 4));
                right_data <= display_right;

            when DISPENSE =>
                left_data <= "1100" & "1000" & "1110" & "1001"; -- "Chng"
                hundreds := to_integer(inserted_amt - item_price) / 100;
                tens     := (to_integer(inserted_amt - item_price) / 10) mod 10;
                ones     := to_integer(inserted_amt - item_price) mod 10;
                display_right := (others => '0');
                display_right(11 downto 8) := std_logic_vector(to_unsigned(hundreds, 4));
                display_right(7 downto 4)  := std_logic_vector(to_unsigned(tens, 4));
                display_right(3 downto 0)  := std_logic_vector(to_unsigned(ones, 4));
                right_data <= display_right;

            when others =>
                left_data  <= (others => '0');
                right_data <= (others => '0');
        end case;
    end process;

    ----------------------------------------------------------------
    -- Display Manager
    ----------------------------------------------------------------
    U4: entity work.Display_Manager
        port map (
            clk        => clk,
            reset      => reset,
            left_data  => left_data,
            right_data => right_data,
            SEG        => SEG,
            AN         => AN,
            dp         => dp
        );

    ----------------------------------------------------------------
    -- State Debug LEDs
    ----------------------------------------------------------------
    LED(0) <= '1' when state_debug = IDLE     else '0';
    LED(1) <= '1' when state_debug = DISPLAY  else '0';
    LED(2) <= '1' when state_debug = INSERT   else '0';
    LED(3) <= '1' when state_debug = DISPENSE else '0';
    LED(4) <= BTNC;

end Structural;

