entity test is
end test;

architecture bench of test is

component B2BC
port(bin: in bit_vector(3 downto 0);
     Dout1: out bit_vector(3 downto 0);
     Dout2: out bit_vector(3 downto 0));
end component;

signal Dout1_TB,Dout2_TB: bit_vector(3 downto 0);
signal bin_TB: bit_vector(3 downto 0);

begin
DUT1: B2BC port map(Dout1=>Dout1_TB,
                    Dout2=>Dout2_TB,
                    bin=>bin_TB);

process
begin
 bin_TB <= "0000"; wait for 10 ns;  -- 0
        bin_TB <= "0001"; wait for 10 ns;  -- 1
        bin_TB <= "0010"; wait for 10 ns;  -- 2
        bin_TB <= "0011"; wait for 10 ns;  -- 3
        bin_TB <= "0100"; wait for 10 ns;  -- 4
        bin_TB <= "0101"; wait for 10 ns;  -- 5
        bin_TB <= "0110"; wait for 10 ns;  -- 6
        bin_TB <= "0111"; wait for 10 ns;  -- 7
        bin_TB <= "1000"; wait for 10 ns;  -- 8
        bin_TB <= "1001"; wait for 10 ns;  -- 9
        bin_TB <= "1010"; wait for 10 ns;  -- 10
        bin_TB <= "1011"; wait for 10 ns;  -- 11
        bin_TB <= "1100"; wait for 10 ns;  -- 12
        bin_TB <= "1101"; wait for 10 ns;  -- 13
        bin_TB <= "1110"; wait for 10 ns;  -- 14
        bin_TB <= "1111"; wait for 10 ns;  -- 15

    end process;

end bench;

