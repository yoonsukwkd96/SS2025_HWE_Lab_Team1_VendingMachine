-- transition to insert state upon button press and switch input
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VendingMachine is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        BTNC      : in  STD_LOGIC;
        BTNU      : in  STD_LOGIC;
        BTNL      : in  STD_LOGIC;
        BTNR      : in  STD_LOGIC;
        BTND      : in  STD_LOGIC;
        SW        : in  STD_LOGIC_VECTOR(2 downto 0);
        LED       : out STD_LOGIC_VECTOR(2 downto 0);
        SEG       : out STD_LOGIC_VECTOR(6 downto 0);
        AN        : out STD_LOGIC_VECTOR(7 downto 0);
        dp        : out STD_LOGIC
    );
end VendingMachine;

architecture Behavioral of VendingMachine is

type state_type is (IDLE, DISPLAY, INSERT, DISPENSE);
signal state, next_state : state_type;

type int_array is array (0 to 2) of integer;
constant item_prices : int_array := (130, 150, 90);
type name_array is array (0 to 2) of string(1 to 4);
constant item_names : name_array := ("colA", "bEEr", "h2O ");

signal price        : integer := 0;
signal inserted     : integer := 0;
signal balance      : integer := 0;
signal item_index   : integer range 0 to 2 := 0;
signal timer_cnt    : integer := 0;
constant ONE_SECOND : integer := 100_000_000;

-- Clock divider for 1Hz display cycling
signal clk_div : integer := 0;
constant CLK_DIV_MAX : integer := 100_000_000;

-- 7-segment control
signal digit_value : STD_LOGIC_VECTOR(3 downto 0);
signal digit_select : integer range 0 to 7 := 0;
signal seg_data     : STD_LOGIC_VECTOR(6 downto 0);
signal show_left  : std_logic_vector(15 downto 0);
signal show_right : std_logic_vector(15 downto 0);
signal name_str    : string(1 to 4);
signal price_val   : integer;

begin

-- FSM state transition logic
process(clk, reset)
begin
    if reset = '1' then
        state <= IDLE;
    elsif rising_edge(clk) then
        state <= next_state;
    end if;
end process;

-- FSM next state logic
process(state, BTNC, SW)
begin
    case state is
        when IDLE =>
            if BTNC = '1' then
                next_state <= DISPLAY;
            else
                next_state <= IDLE;
            end if;

        when DISPLAY =>
            if BTNC = '1' and SW /= "000" then
                case SW is
                    when "001" => price <= item_prices(0);
                    when "010" => price <= item_prices(1);
                    when "100" => price <= item_prices(2);
                    when others => price <= 0;
                end case;
                next_state <= INSERT;
            else
                next_state <= DISPLAY;
            end if;

        when INSERT =>
            next_state <= INSERT;  -- To be completed in next stage

        when DISPENSE =>
            next_state <= IDLE;
    end case;
end process;

-- Time-based item update process
process(clk)
begin
    if rising_edge(clk) then
        if state = DISPLAY then
            if timer_cnt < ONE_SECOND then
                timer_cnt <= timer_cnt + 1;
            else
                timer_cnt <= 0;
                if item_index = 2 then
                    item_index <= 0;
                else
                    item_index <= item_index + 1;
                end if;
            end if;
        else
            timer_cnt <= 0;
        end if;
    end if;
end process;

-- Update item name and price for display
process(state, item_index)
begin
    if state = DISPLAY then
        name_str <= item_names(item_index);
        price_val <= item_prices(item_index);
    else
        name_str <= "    ";
        price_val <= 0;
    end if;
end process;

-- Convert name_str to show_left
process(name_str)
begin
    for i in 0 to 3 loop
        case name_str(i+1) is
            when '0' => show_left(i*4+3 downto i*4) <= "0000";
            when '1' => show_left(i*4+3 downto i*4) <= "0001";
            when '2' => show_left(i*4+3 downto i*4) <= "0010";
            when '3' => show_left(i*4+3 downto i*4) <= "0011";
            when '4' => show_left(i*4+3 downto i*4) <= "0100";
            when '5' => show_left(i*4+3 downto i*4) <= "0101";
            when '6' => show_left(i*4+3 downto i*4) <= "0110";
            when '7' => show_left(i*4+3 downto i*4) <= "0111";
            when '8' => show_left(i*4+3 downto i*4) <= "1000";
            when '9' => show_left(i*4+3 downto i*4) <= "1001";
            when others => show_left(i*4+3 downto i*4) <= "1111"; -- blank/default
        end case;
    end loop;
end process;

-- Convert price_val to show_right (e.g., 130 ? "1.30")
process(price_val)
    variable hundreds, tens, ones : integer;
begin
    hundreds := price_val / 100;
    tens := (price_val / 10) mod 10;
    ones := price_val mod 10;
    show_right(15 downto 12) <= conv_std_logic_vector(0, 4); -- blank
    show_right(11 downto 8)  <= conv_std_logic_vector(hundreds, 4);
    show_right(7 downto 4)   <= conv_std_logic_vector(tens, 4);
    show_right(3 downto 0)   <= conv_std_logic_vector(ones, 4);
end process;

-- Display update process (rotates through 8 digits)
process(clk)
begin
    if rising_edge(clk) then
        digit_select <= (digit_select + 1) mod 8;
        case digit_select is
            when 0 => digit_value <= show_left(3 downto 0);      AN <= "11111110";
            when 1 => digit_value <= show_left(7 downto 4);      AN <= "11111101";
            when 2 => digit_value <= show_left(11 downto 8);     AN <= "11111011";
            when 3 => digit_value <= show_left(15 downto 12);    AN <= "11110111";
            when 4 => digit_value <= show_right(3 downto 0);     AN <= "11101111";
            when 5 => digit_value <= show_right(7 downto 4);     AN <= "11011111";
            when 6 => digit_value <= show_right(11 downto 8);    AN <= "10111111";
            when 7 => digit_value <= show_right(15 downto 12);   AN <= "01111111";
            when others => null;
        end case;

        case digit_value is
            when "0000" => seg_data <= "0000001"; -- 0
            when "0001" => seg_data <= "1001111"; -- 1
            when "0010" => seg_data <= "0010010"; -- 2
            when "0011" => seg_data <= "0000110"; -- 3
            when "0100" => seg_data <= "1001100"; -- 4
            when "0101" => seg_data <= "0100100"; -- 5
            when "0110" => seg_data <= "0100000"; -- 6
            when "0111" => seg_data <= "0001111"; -- 7
            when "1000" => seg_data <= "0000000"; -- 8
            when "1001" => seg_data <= "0000100"; -- 9
            when others => seg_data <= "1111111"; -- blank
        end case;
    end if;
end process;

SEG <= seg_data;
dp <= '0';

-- LED State Indicators
LED(0) <= '1' when state = IDLE else '0';
LED(1) <= '1' when state = DISPLAY else '0';
LED(2) <= '1' when state = INSERT or state = DISPENSE else '0';

end Behavioral;