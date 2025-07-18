entity test is
end test;

architecture decodertB of test is

    signal A1_tb : bit_vector(3 downto 0);
    signal a_tb, b_tb, c_tb, d_tb, e_tb, f_tb, g_tb : bit;

    
    component BCD_to_7seg
        port(A1: in bit_vector(3 downto 0);
     a,b,c,d,e,f,g: out bit);
    end component;

begin


    DUT1: BCD_to_7seg port map (
        A1 =>A1_tb,
        a => a_tb, b => b_tb, c => c_tb, d => d_tb, e => e_tb, f => f_tb, g => g_tb
    );

    
    process
    begin
       
        A1_tb <= "0000";  --0
        wait for 10 ns;
        
        --  1
        A1_tb <= "0001"; --1
        wait for 10 ns;
        
       
        A1_tb <= "0010"; --2
        wait for 10 ns;
        
       
        A1_tb <= "0011"; --3
        wait for 10 ns;
        
       
        A1_tb <= "0100"; --4
        wait for 10 ns;
        
        
        A1_tb <= "0101"; --5
        wait for 10 ns;
        
        
        A1_tb <= "0110"; --6
        wait for 10 ns;
        
        
        A1_tb <= "0111"; --7
        wait for 10 ns;
        
        
        A1_tb <= "1000"; --8
        wait for 10 ns;
        
        
        A1_tb <= "1001"; --9
        wait for 10 ns;
        
        
        wait;
    end process;

end decodertB;
