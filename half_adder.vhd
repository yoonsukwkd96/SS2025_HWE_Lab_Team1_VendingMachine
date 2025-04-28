library IEEE; -- library for logic definitions
use IEEE.STD_LOGIC_1164.ALL; -- loads all logic operations

entity halfadder is
    Port(
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Sum : out STD_LOGIC;
        Carry : out STD_LOGIC
    );
end halfadder;

architecture behavioral of halfadder is
begin
    Sum <= (A AND (NOT B)) OR ((NOT A) AND B); -- sum = 1 when A and B different
    Carry <= A AND B; -- carry = 1 when A and B = 1
end behavioral;