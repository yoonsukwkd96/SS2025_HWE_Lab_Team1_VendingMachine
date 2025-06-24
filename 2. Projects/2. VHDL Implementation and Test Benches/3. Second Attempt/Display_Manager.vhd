library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.types_pkg.all;

entity Display_Manager is
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        left_data   : in  std_logic_vector(15 downto 0);
        right_data  : in  std_logic_vector(15 downto 0);
        SEG         : out std_logic_vector(6 downto 0);
        AN          : out std_logic_vector(7 downto 0);
        dp          : out std_logic
    );
end Display_Manager;

architecture Behavioral of Display_Manager is

    signal display_bus : std_logic_vector(31 downto 0);
    signal digit_value : std_logic_vector(3 downto 0);
    signal digit_select : integer range 0 to 7 := 0;
    signal seg_data : std_logic_vector(6 downto 0);

    -- BCD to 7-segment conversion
    function bcd_to_seven_seg(bcd : std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
        case bcd is
            when "0000" => return "0000001"; -- 0
            when "0001" => return "1001111"; -- 1
            when "0010" => return "0010010"; -- 2
            when "0011" => return "0000110"; -- 3
            when "0100" => return "1001100"; -- 4
            when "0101" => return "0100100"; -- 5
            when "0110" => return "0100000"; -- 6
            when "0111" => return "0001111"; -- 7
            when "1000" => return "0000000"; -- 8
            when "1001" => return "0000100"; -- 9
            when others => return "1111111"; -- blank
        end case;
    end;

begin

    display_bus <= left_data & right_data;

    process(clk, reset)
    begin
        if reset = '1' then
            digit_select <= 0;
        elsif rising_edge(clk) then
            digit_select <= (digit_select + 1) mod 8;
            digit_value <= display_bus(digit_select*4+3 downto digit_select*4);
            AN <= not std_logic_vector(to_unsigned(1, 8) sll digit_select);
            seg_data <= bcd_to_seven_seg(digit_value);
        end if;
    end process;

    SEG <= seg_data;
    dp  <= '0';

end Behavioral;

