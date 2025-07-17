library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity up_down_counter_one_proc is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        enable  : in  std_logic;
        updown  : in  std_logic;  -- 1 = up, 0 = down
        count   : out std_logic_vector(2 downto 0)
    );
end up_down_counter_one_proc;

architecture Behavioral of up_down_counter_one_proc is

    signal state : unsigned(2 downto 0) := (others => '0');

begin

    process(clk, reset)
    begin
        if reset = '1' then
            state <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                if updown = '1' then
                    if state = "111" then
                        state <= (others => '0'); -- ???7???0
                    else
                        state <= state + 1;
                    end if;
                else
                    if state = "000" then
                        state <= "111"; -- ???0???7
                    else
                        state <= state - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    count <= std_logic_vector(state);

end Behavioral;

