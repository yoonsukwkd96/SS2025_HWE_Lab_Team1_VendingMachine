entity tb_clk_divider is
end entity;

architecture behavior of tb_clk_divider is

    -- ????
    signal CLK   : BIT := '0';
    signal CLK_N : BIT;

    constant N : integer := 4;  -- ???????????????
    constant CLK_PERIOD : time := 10 ns;

begin

    -- ???????
    uut: entity work.clk_divider
        generic map (N => N)
        port map (
            CLK   => CLK,
            CLK_N => CLK_N
        );

    -- ?????
    clk_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- ????
    monitor_process: process
    begin
        wait for 0 ns;  -- ????

        -- ???????????????????????
        -- ?????????????
        for i in 0 to 30 loop
            wait for CLK_PERIOD;
            report "Time: " & time'image(now) & 
                   " CLK_N = " & bit'image(CLK_N);
        end loop;

        wait;
    end process;

end behavior;
