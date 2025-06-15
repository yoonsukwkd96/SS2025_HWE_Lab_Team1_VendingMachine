library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Coin_Handler is
    Port (
        clk             : in  std_logic;
        reset           : in  std_logic;
        BTNU, BTNL, BTNR, BTND : in std_logic;
        inserted_amount : out unsigned(9 downto 0)
    );
end Coin_Handler;

architecture Behavioral of Coin_Handler is

    signal amount : unsigned(9 downto 0) := (others => '0');
    signal prev_BTNU, prev_BTNL, prev_BTNR, prev_BTND : std_logic := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                amount <= (others => '0');
            else
                if (BTNU = '1' and prev_BTNU = '0') then
                    amount <= amount + 10;
                elsif (BTNL = '1' and prev_BTNL = '0') then
                    amount <= amount + 20;
                elsif (BTNR = '1' and prev_BTNR = '0') then
                    amount <= amount + 50;
                elsif (BTND = '1' and prev_BTND = '0') then
                    amount <= amount + 100;
                end if;
            end if;

            prev_BTNU <= BTNU;
            prev_BTNL <= BTNL;
            prev_BTNR <= BTNR;
            prev_BTND <= BTND;
        end if;
    end process;

    inserted_amount <= amount;

end Behavioral;

