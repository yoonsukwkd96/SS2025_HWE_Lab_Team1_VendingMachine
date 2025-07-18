library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity JKff is
port(clk: in std_logic;
     j  : in std_logic;
     k  : in std_logic;
     q  : out std_logic;
     qn : out std_logic
);
end JKff;

architecture behavior of JKff is
signal q0: std_logic:='0';
begin

process(clk)
begin
if rising_edge(clk) then
if j = '0' and k = '0' then
                -- no change
                q0 <= q0;
            elsif j = '0' and k = '1' then
                q0 <= '0';
            elsif j = '1' and k = '0' then
                q0 <= '1';
            elsif j = '1' and k = '1' then
                q0 <= not q0;
            end if;
        end if;
    end process; 
q <=q0;
qn<=not q0;
end behavior;
