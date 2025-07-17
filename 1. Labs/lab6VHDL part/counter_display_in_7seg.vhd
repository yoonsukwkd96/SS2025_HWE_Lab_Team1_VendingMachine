library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_display_in_7seg is
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        enable  : in  std_logic;
        updown  : in  std_logic;
        anodes  : out std_logic_vector(7 downto 0);
        display : out std_logic_vector(7 downto 0)
    );
end counter_display_in_7seg;

architecture structural of counter_display_in_7seg is

    -- ======= ???? =======
    signal count     : std_logic_vector(2 downto 0);
    signal bcd_input : std_logic_vector(3 downto 0);
    signal a, b, c, d, e, f, g : std_logic;
    signal cathode0  : std_logic_vector(6 downto 0);

    --===============================
    -- 1) up_down_counter_one_proc ? component
    --===============================
    component up_down_counter_one_proc is
        port (
            clk    : in  std_logic;
            reset  : in  std_logic;
            enable : in  std_logic;
            updown : in  std_logic;
            count  : out std_logic_vector(2 downto 0)
        );
    end component;

    --===============================
    -- 2) BCD_to_7seg ? component
    --===============================
    component BCD_to_7seg is
        port (
            A1 : in  std_logic_vector(3 downto 0);
            a  : out std_logic;
            b  : out std_logic;
            c  : out std_logic;
            d  : out std_logic;
            e  : out std_logic;
            f  : out std_logic;
            g  : out std_logic
        );
    end component;

    --==============================================
    -- 3) SevenSegmentController ? component
    --==============================================
    component SevenSegmentController is
        port (
            clk                 : in  std_logic;
            cathodeController_0 : in  std_logic_vector(6 downto 0);
            cathodeController_1 : in  std_logic_vector(6 downto 0);
            anodes              : out std_logic_vector(7 downto 0);
            display             : out std_logic_vector(7 downto 0)
        );
    end component;

begin

    ----------------------------------------------------------------
    -- 1) ??? 3-bit ?????
    counter_inst : up_down_counter_one_proc
        port map (
            clk    => clk,
            reset  => reset,
            enable => enable,
            updown => updown,
            count  => count
        );

    ----------------------------------------------------------------
    -- 2) ??? & ??????????? '0'?? 3 ? = count
    bcd_input(3)        <= '0';
    bcd_input(2 downto 0) <= count;

    ----------------------------------------------------------------
    -- 3) ??? BCD_to_7seg ???
    decoder_inst : BCD_to_7seg
        port map (
            A1 => bcd_input,
            a  => a,
            b  => b,
            c  => c,
            d  => d,
            e  => e,
            f  => f,
            g  => g
        );

    ----------------------------------------------------------------
    -- 4) ?? a~g ?? 0 ???????
    cathode0 <= a & b & c & d & e & f & g;

    ----------------------------------------------------------------
    -- 5) ???????????????? 0 ????
    display_inst : SevenSegmentController
        port map (
            clk                 => clk,
            cathodeController_0 => cathode0,
            cathodeController_1 => (others => '1'),  -- ???? 1 ?
            anodes              => anodes,
            display             => display
        );

end structural;


