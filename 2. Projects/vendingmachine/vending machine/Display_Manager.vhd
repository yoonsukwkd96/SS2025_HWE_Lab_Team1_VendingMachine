library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_Manager is
    Port (
        clk          : in  std_logic;                     -- 系统时钟 (e.g. 100 MHz)
        reset        : in  std_logic;                     -- 同步复位，高电平有效
        display_text : in  std_logic_vector(63 downto 0); -- 8 字符 ASCII 串
        SEG          : out std_logic_vector(6 downto 0);  -- 段选，低电平有效
        AN           : out std_logic_vector(7 downto 0);  -- 位选，低电平有效
        dp           : out std_logic                      -- 小数点，低电平有效
    );
end Display_Manager;

architecture Behavioral of Display_Manager is

    -- 用来做时钟分频的计数器，大小根据主频和想要的刷新频率调整
    signal clk_divider    : unsigned(17 downto 0) := (others => '0');  
    -- 扫描的位索引
    signal digit_index    : integer range 0 to 7 := 0;
    -- 当前要显示的字符 ASCII
    signal current_char   : std_logic_vector(7 downto 0);
    -- 译码后（高电平有效）的 7 段编码
    signal seg_temp       : std_logic_vector(6 downto 0);

begin

    ----------------------------------------------------------------------------
    -- 1) 分频与扫描
    ----------------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                clk_divider <= (others => '0');
                digit_index <= 0;
            else
                -- 分频计数到 200 000（100 MHz / 200 000 = 500 Hz 刷新率）
                if clk_divider = 200000 - 1 then
                    clk_divider <= (others => '0');
                    -- 循环扫描 0…7
                    if digit_index = 7 then
                        digit_index <= 0;
                    else
                        digit_index <= digit_index + 1;
                    end if;
                else
                    clk_divider <= clk_divider + 1;
                end if;
            end if;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- 2) 抽取当前 ASCII 字符
    ----------------------------------------------------------------------------
    current_char <= display_text(
                        63 - digit_index*8
                      downto
                        56 - digit_index*8
                   );

    ----------------------------------------------------------------------------
    -- 3) ASCII → 7 段译码（高电平有效）
    ----------------------------------------------------------------------------
    process(current_char)
    begin
        case current_char is
            when x"30" => seg_temp <= "0000001"; -- '0'
            when x"31" => seg_temp <= "1001111"; -- '1'
            when x"32" => seg_temp <= "0010010"; -- '2'
            when x"33" => seg_temp <= "0000110"; -- '3'
            when x"34" => seg_temp <= "1001100"; -- '4'
            when x"35" => seg_temp <= "0100100"; -- '5'
            when x"36" => seg_temp <= "0100000"; -- '6'
            when x"37" => seg_temp <= "0001111"; -- '7'
            when x"38" => seg_temp <= "0000000"; -- '8'
            when x"39" => seg_temp <= "0000100"; -- '9'
            when x"41" => seg_temp <= "0001000"; -- 'A'
            when x"42" => seg_temp <= "1100000"; -- 'b'
            when x"45" => seg_temp <= "0110000"; -- 'E'
            when x"4F" => seg_temp <= "0000001"; -- 'O'
            when x"52" => seg_temp <= "0111001"; -- 'r'
            when x"63" => seg_temp <= "0110001"; -- 'c'
            when x"68" => seg_temp <= "1001000"; -- 'h'
            when x"6C" => seg_temp <= "1110001"; -- 'l'
            when x"6F" => seg_temp <= "0000001"; -- 'o'
            when x"20" => seg_temp <= "1111111"; -- 空格
            when x"67" => seg_temp <= "0000100"; -- 'g'
            when others => seg_temp <= "1111111"; -- 默认空白
        end case;
    end process;

    ----------------------------------------------------------------------------
    -- 4) 输出到数码管
    ----------------------------------------------------------------------------
    SEG <=  seg_temp;                                       -- 低电平点亮
    AN  <= not std_logic_vector(to_unsigned(2**digit_index,8)); -- 选通当前位
    dp  <= '0' when (digit_index = 1 or digit_index = 5) else '1'; -- 在第 2、6 位点 dp

end Behavioral;

