library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package types_pkg is

    -- FSM states
    type state_type is (IDLE, DISPLAY, INSERT, DISPENSE);

    -- Character encoding: each digit is 4-bit BCD or character
    subtype display_char is std_logic_vector(3 downto 0);
    type display_array is array (0 to 3) of display_char;

    -- Item info: name + price
    type item_info is record
        name  : display_array;
        price : unsigned(7 downto 0);
    end record;

    -- All items
    type item_array is array (0 to 2) of item_info;

end package;
