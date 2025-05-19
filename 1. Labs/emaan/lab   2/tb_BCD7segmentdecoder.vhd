library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_BCD7segment is
end tb_BCD7segment;

architecture behavior of tb_BCD7segment is
   
    signal B0, B1, B2, B3 : bit := '0';
    signal a, b, c, d, e, f, g : bit;

begin
 
    stimulus: process
    begin
        
        -- Test case 0
        B0 <= '0'; B1 <= '0'; B2 <= '0'; B3 <= '0';  -- BCD 0
        wait for 10 ns;

        -- Test case 1
        B0 <= '1'; B1 <= '0'; B2 <= '0'; B3 <= '0';  -- BCD 1
        wait for 10 ns;

        -- Test case 2
        B0 <= '0'; B1 <= '1'; B2 <= '0'; B3 <= '0';  -- BCD 2
        wait for 10 ns;

        -- Test case 3
        B0 <= '1'; B1 <= '1'; B2 <= '0'; B3 <= '0';  -- BCD 3
        wait for 10 ns;

        -- Test case 4
        B0 <= '0'; B1 <= '0'; B2 <= '1'; B3 <= '0';  -- BCD 4
        wait for 10 ns;

        -- Test case 5
        B0 <= '1'; B1 <= '0'; B2 <= '1'; B3 <= '0';  -- BCD 5
        wait for 10 ns;

        -- Test case 6
        B0 <= '0'; B1 <= '1'; B2 <= '1'; B3 <= '0';  -- BCD 6
        wait for 10 ns;

        -- Test case 7
        B0 <= '1'; B1 <= '1'; B2 <= '1'; B3 <= '0';  -- BCD 7
        wait for 10 ns;

        -- Test case 8
        B0 <= '0'; B1 <= '0'; B2 <= '0'; B3 <= '1';  -- BCD 8
        wait for 10 ns;

        -- Test case 9
        B0 <= '1'; B1 <= '0'; B2 <= '0'; B3 <= '1';  -- BCD 9
        wait for 10 ns;

     wait;
    end process;
end behavior;
