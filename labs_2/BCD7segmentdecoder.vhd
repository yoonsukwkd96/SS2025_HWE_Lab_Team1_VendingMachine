library IEEE;


entity BCD7segment is
    port (
        B0, B1, B2, B3 : in bit;
        a, b, c, d, e, f, g : out bit
    );
end BCD7segment;

architecture behavioral of BCD7segment is
begin
    process (B0, B1, B2, B3)
        variable bcd : integer range 0 to 15;
    begin
        -- Convert bits to integer
        bcd := 0;
        if B0 = '1' then bcd := bcd + 1; end if;
        if B1 = '1' then bcd := bcd + 2; end if;
        if B2 = '1' then bcd := bcd + 4; end if;
        if B3 = '1' then bcd := bcd + 8; end if;

        -- Decode to segments
        case bcd is
            when 0  =>
                a <= '1'; b <= '1'; c <= '1'; d <= '1'; e <= '1'; f <= '1'; g <= '0';
            when 1  =>
                a <= '0'; b <= '1'; c <= '1'; d <= '0'; e <= '0'; f <= '0'; g <= '0';
            when 2  =>
                a <= '1'; b <= '1'; c <= '0'; d <= '1'; e <= '1'; f <= '0'; g <= '1';
            when 3  =>
                a <= '1'; b <= '1'; c <= '1'; d <= '1'; e <= '0'; f <= '0'; g <= '1';
            when 4  =>
                a <= '0'; b <= '1'; c <= '1'; d <= '0'; e <= '0'; f <= '1'; g <= '1';
            when 5  =>
                a <= '1'; b <= '0'; c <= '1'; d <= '1'; e <= '0'; f <= '1'; g <= '1';
            when 6  =>
                a <= '1'; b <= '0'; c <= '1'; d <= '1'; e <= '1'; f <= '1'; g <= '1';
            when 7  =>
                a <= '1'; b <= '1'; c <= '1'; d <= '0'; e <= '0'; f <= '0'; g <= '0';
            when 8  =>
                a <= '1'; b <= '1'; c <= '1'; d <= '1'; e <= '1'; f <= '1'; g <= '1';
            when 9  =>
                a <= '1'; b <= '1'; c <= '1'; d <= '1'; e <= '0'; f <= '1'; g <= '1';
            when others =>
                a <= '0'; b <= '0'; c <= '0'; d <= '0'; e <= '0'; f <= '0'; g <= '0';
        end case;
    end process;
end behavioral;
