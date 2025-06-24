library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.types_pkg.all;

entity FSM_Controller is
    Port (
        clk           : in  std_logic;
        reset         : in  std_logic;
        BTNC          : in  std_logic;
        SW            : in  std_logic_vector(2 downto 0);
        inserted      : in  unsigned(7 downto 0);
        price_reg     : in  unsigned(7 downto 0);
        current_state : out state_type;
        state_debug   : out state_type
    );
end FSM_Controller;

architecture Behavioral of FSM_Controller is
    signal state_reg, next_state : state_type := IDLE;

    -- Edge detection for BTNC
    signal BTNC_dly : std_logic := '0';
    signal BTNC_rise : std_logic := '0';
begin

    -- Synchronize and detect rising edge of BTNC
    process(clk, reset)
    begin
        if reset = '1' then
            BTNC_dly <= '0';
            BTNC_rise <= '0';
        elsif rising_edge(clk) then
            BTNC_rise <= BTNC and not BTNC_dly;
            BTNC_dly <= BTNC;
        end if;
    end process;

    -- FSM register
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= IDLE;
        elsif rising_edge(clk) then
            state_reg <= next_state;
        end if;
    end process;

    -- FSM next-state logic using BTNC_rise
    process(state_reg, BTNC_rise, SW, inserted, price_reg)
    begin
        next_state <= state_reg;

        case state_reg is
            when IDLE =>
                if BTNC_rise = '1' then
                    next_state <= DISPLAY;
                end if;

            when DISPLAY =>
                if BTNC_rise = '1' and SW /= "000" then
                    next_state <= INSERT;
                end if;

            when INSERT =>
                if BTNC_rise = '1' and inserted >= price_reg then
                    next_state <= DISPENSE;
                end if;

            when DISPENSE =>
                if BTNC_rise = '1' then
                    next_state <= IDLE;
                end if;
        end case;
    end process;

    current_state <= state_reg;
    state_debug   <= state_reg;

end Behavioral;

