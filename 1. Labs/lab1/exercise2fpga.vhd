library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_Display is
    port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0);
        B    : in  STD_LOGIC_VECTOR(3 downto 0);
        Sel  : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        SEG  : out STD_LOGIC_VECTOR(7 downto 0); -- 7段显示（a-g + dp）
        AN   : out STD_LOGIC_VECTOR(7 downto 0)  -- 位选控制
    );
end Top_Display;

architecture structural of Top_Display is

    signal S1, S2, S3, S4 : STD_LOGIC;
    signal Cout           : STD_LOGIC;
    signal result_bin     : STD_LOGIC_VECTOR(3 downto 0);
    signal Dout1, Dout2   : STD_LOGIC_VECTOR(3 downto 0);

    signal seg1, seg2     : STD_LOGIC_VECTOR(6 downto 0); -- 显示数据

    -- 控制器组件
    component SevenSegmentController
        port (
            clk : in STD_LOGIC;
            cathodeController_0, cathodeController_1 : in STD_LOGIC_VECTOR(6 downto 0);
            anodes : out STD_LOGIC_VECTOR(7 downto 0);
            display : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- 加法器组件
    component adder_substractor
        port(
            C1, C2, C3, C4 : in STD_LOGIC;
            D1, D2, D3, D4 : in STD_LOGIC;
            I1            : in STD_LOGIC;
            S11, S22, S33, S44 : out STD_LOGIC;
            Coutt         : out STD_LOGIC
        );
    end component;

    -- BCD转换器
    component B2BC
        port(
            bin   : in  STD_LOGIC_VECTOR(3 downto 0);
            Dout1 : out STD_LOGIC_VECTOR(3 downto 0);
            Dout2 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- BCD转7段显示
    component BCD_to_7seg
        port(
            A1 : in  STD_LOGIC_VECTOR(3 downto 0);
            a, b, c, d, e, f, g : out STD_LOGIC
        );
    end component;

begin

    -- 加/减法器
    U1: adder_substractor port map(
        C1 => A(0), C2 => A(1), C3 => A(2), C4 => A(3),
        D1 => B(0), D2 => B(1), D3 => B(2), D4 => B(3),
        I1 => Sel,
        S11 => S1, S22 => S2, S33 => S3, S44 => S4,
        Coutt => Cout
    );

    result_bin <= S4 & S3 & S2 & S1;

    -- 二进制转BCD
    U2: B2BC port map(
        bin   => result_bin,
        Dout1 => Dout1,
        Dout2 => Dout2
    );

    -- BCD转7段
    U3: BCD_to_7seg port map(
        A1 => Dout2,
        a => seg1(6), b => seg1(5), c => seg1(4), d => seg1(3),
        e => seg1(2), f => seg1(1), g => seg1(0)
    );

    U4: BCD_to_7seg port map(
        A1 => Dout1,
        a => seg2(6), b => seg2(5), c => seg2(4), d => seg2(3),
        e => seg2(2), f => seg2(1), g => seg2(0)
    );

    -- 数码管刷新控制器
    U5: SevenSegmentController port map(
        clk => CLK,
        cathodeController_0 => seg1,
        cathodeController_1 => seg2,
        anodes => AN,
        display => SEG
    );

end structural;




