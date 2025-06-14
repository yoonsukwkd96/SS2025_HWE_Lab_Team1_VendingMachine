library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_Controller is
    Port (
        clk            : in  std_logic;
        reset          : in  std_logic;
        BTNC           : in  std_logic;
        SW             : in  std_logic_vector(2 downto 0);
        inserted_amount: in  unsigned(13 downto 0); -- max 9999 (99.99?)
        LED            : out std_logic_vector(3 downto 0);
        display_text   : out std_logic_vector(63 downto 0)
    );
end FSM_Controller;

architecture Behavioral of FSM_Controller is

    -- Convert string (8 chars) to std_logic_vector
    function string_to_ascii(s : string) return std_logic_vector is
        variable result : std_logic_vector(63 downto 0) := (others => '0');
    begin
        for i in 0 to 7 loop
            if i < s'length then
                result(63 - i*8 downto 56 - i*8) := std_logic_vector(to_unsigned(character'pos(s(i+1)), 8));
            else
                result(63 - i*8 downto 56 - i*8) := x"20";  -- space
            end if;
        end loop;
        return result;
    end function;

    -- Convert 14-bit unsigned cents value to 4-digit ASCII string
    function format_price_to_string(value : unsigned(13 downto 0)) return string is
        variable str     : string(1 to 4);
        variable int_val : integer := to_integer(value);
    begin
        str(1) := character'val(int_val / 1000 mod 10 + character'pos('0'));
        str(2) := character'val(int_val / 100 mod 10 + character'pos('0'));
        str(3) := character'val(int_val / 10 mod 10 + character'pos('0'));
        str(4) := character'val(int_val mod 10 + character'pos('0'));
        return str;
    end function;

    type state_type is (IDLE, DISPLAY, INSERT, DISPENSE);
    signal current_state, next_state : state_type;

    signal BTNC_prev : std_logic := '0';
    signal BTNC_edge : std_logic;

    signal display_text_internal : std_logic_vector(63 downto 0);
    signal selected_price : unsigned(13 downto 0) := (others => '0');

begin

    -- Output assignment
    display_text <= display_text_internal;

    -- Detect rising edge of BTNC
    process(clk)
    begin
        if rising_edge(clk) then
            BTNC_prev <= BTNC;
        end if;
    end process;

    BTNC_edge <= '1' when (BTNC = '1' and BTNC_prev = '0') else '0';

    -- State register
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- FSM transitions
    process(current_state, BTNC_edge, SW, inserted_amount, selected_price)
    begin
        case current_state is
            when IDLE =>
                if BTNC_edge = '1' then
                    next_state <= DISPLAY;
                else
                    next_state <= IDLE;
                end if;

            when DISPLAY =>
                if BTNC_edge = '1' and (SW = "001" or SW = "010" or SW = "100") then
                    next_state <= INSERT;
                else
                    next_state <= DISPLAY;
                end if;

            when INSERT =>
                if BTNC_edge = '1' and inserted_amount >= selected_price then
                    next_state <= DISPENSE;
                else
                    next_state <= INSERT;
                end if;

            when DISPENSE =>
                if BTNC_edge = '1' and SW = "000" then
                    next_state <= IDLE;
                else
                    next_state <= DISPENSE;
                end if;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

    -- LED output
    with current_state select
        LED <= "0001" when IDLE,
               "0010" when DISPLAY,
               "0100" when INSERT,
               "1000" when DISPENSE;

    -- Display logic
    process(current_state, SW, inserted_amount, selected_price)
        variable price_str     : string(1 to 4);
        variable inserted_str  : string(1 to 4);
        variable full_str      : string(1 to 8);
        variable temp_change   : unsigned(13 downto 0);
        variable chg_str       : string(1 to 4);
    begin
        case current_state is

            when IDLE =>
                if SW = "001" then
                    selected_price <= to_unsigned(130, 14);
                    display_text_internal <= string_to_ascii("01300000");
                elsif SW = "010" then
                    selected_price <= to_unsigned(150, 14);
                    display_text_internal <= string_to_ascii("01500000");
                elsif SW = "100" then
                    selected_price <= to_unsigned(90, 14);
                    display_text_internal <= string_to_ascii("00900000");
                else
                    selected_price <= (others => '0');
                    display_text_internal <= string_to_ascii("        ");
                end if;

            when DISPLAY =>
                case SW is
                    when "001" =>
                        selected_price <= to_unsigned(130, 14);
                        display_text_internal <= string_to_ascii("colA0130");
                    when "010" =>
                        selected_price <= to_unsigned(150, 14);
                        display_text_internal <= string_to_ascii("bEEr0150");
                    when "100" =>
                        selected_price <= to_unsigned(90, 14);
                        display_text_internal <= string_to_ascii("h2O 0090");
                    when others =>
                        display_text_internal <= string_to_ascii("        ");
                end case;

            when INSERT =>
                price_str    := format_price_to_string(selected_price);
                inserted_str := format_price_to_string(inserted_amount);
                full_str     := price_str & inserted_str;
                display_text_internal <= string_to_ascii(full_str);

            when DISPENSE =>
                if inserted_amount >= selected_price then
                    temp_change := inserted_amount - selected_price;
                else
                    temp_change := (others => '0');
                end if;

                chg_str(1) := character'val(to_integer(temp_change / 1000 mod 10) + character'pos('0'));
                chg_str(2) := character'val(to_integer(temp_change / 100 mod 10) + character'pos('0'));
                chg_str(3) := character'val(to_integer(temp_change / 10 mod 10) + character'pos('0'));
                chg_str(4) := character'val(to_integer(temp_change mod 10) + character'pos('0'));

                display_text_internal <= string_to_ascii("CHGE" & chg_str);

            when others =>
                display_text_internal <= string_to_ascii("        ");
        end case;
    end process;

end Behavioral;

