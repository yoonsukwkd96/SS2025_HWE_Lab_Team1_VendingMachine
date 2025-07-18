library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.types_pkg.all;

entity Item_ROM is
    Port (
        SW         : in  std_logic_vector(2 downto 0);
        item_name  : out display_array;
        item_price : out unsigned(7 downto 0)
    );
end Item_ROM;

architecture Behavioral of Item_ROM is
    constant items : item_array := (
        (name => ("1100", "1111", "1100", "0001"), price => to_unsigned(130, 8)), -- "colA"
        (name => ("1011", "1110", "1110", "1010"), price => to_unsigned(150, 8)), -- "bEEr"
        (name => ("1000", "1000", "1111", "0000"), price => to_unsigned(90, 8))   -- "h2O "
    );

    signal index : integer range 0 to 2 := 0;

begin

    process(SW)
    begin
        case SW is
            when "001" => index <= 0;
            when "010" => index <= 1;
            when "100" => index <= 2;
            when others => index <= 0;
        end case;
    end process;

    item_name  <= items(index).name;
    item_price <= items(index).price;

end Behavioral;

