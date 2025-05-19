
entity FullAdder_tb is
end FullAdder_tb;

architecture behavioral of FullAdder_tb is
  component FullAdderexample
	port( A,B,Cin : in bit;
	     S,Cout : out bit);
 end component;

signal A_tb,B_tb,Cin_tb : bit;
signal S_tb,Cout_tb : bit;

begin 
 DUT1: FullAdderexample port map (A=>A_tb, 
				B=>B_tb,
				Cin=>Cin_tb,
				S=>S_tb,
				Cout=>Cout_tb);
process is
begin
        
        A_tb <= '0'; B_tb <= '0'; Cin_tb <= '0';
        wait for 10 ns;

        
        A_tb <= '0'; B_tb <= '0'; Cin_tb <= '1';
        wait for 10 ns;

        
        A_tb <= '0'; B_tb <= '1'; Cin_tb <= '0';
        wait for 10 ns;

        
        A_tb <= '0'; B_tb <= '1'; Cin_tb <= '1';
        wait for 10 ns;

        
        A_tb <= '1'; B_tb <= '0'; Cin_tb <= '0';
        wait for 10 ns;

        
        A_tb <= '1'; B_tb <= '0'; Cin_tb <= '1';
        wait for 10 ns;

        
        A_tb <= '1'; B_tb <= '1'; Cin_tb <= '0';
        wait for 10 ns;

        
        A_tb <= '1'; B_tb <= '1'; Cin_tb <= '1';
        wait for 10 ns;

        
wait;
end process;
        
end behavioral;