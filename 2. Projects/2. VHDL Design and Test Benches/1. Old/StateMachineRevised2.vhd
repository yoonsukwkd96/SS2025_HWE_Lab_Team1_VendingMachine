library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VendingMachine is
  port (
    clk        : in  std_logic;
    reset      : in  std_logic;
    product1   : in  std_logic;
    product2   : in  std_logic;
    product3   : in  std_logic;
    coin_10c   : in  std_logic;
    coin_20c   : in  std_logic;
    coin_50c   : in  std_logic;
    coin_1e    : in  std_logic;
    dispense   : out std_logic;
    refund     : out std_logic;
    seg        : out std_logic_vector(6 downto 0); -- 7-segment segments
    an         : out std_logic_vector(3 downto 0)  -- 7-segment anodes (for multiplexing)
  );
end entity;

architecture Behavioral of VendingMachine is

  type state_type is (idle, product_select, insert_coin, check, dispensing, refunding);
  signal current_state, next_state : state_type;

  signal amount           : unsigned(7 downto 0) := (others => '0');
  signal selected_price   : unsigned(7 downto 0) := (others => '0');
  signal product_id       : unsigned(1 downto 0); -- 00: none, 01: P1, 10: P2, 11: P3

  constant P1_PRICE : unsigned(7 downto 0) := to_unsigned(20, 8);
  constant P2_PRICE : unsigned(7 downto 0) := to_unsigned(50, 8);
  constant P3_PRICE : unsigned(7 downto 0) := to_unsigned(100, 8);

begin

  -- State register
  process(clk, reset)
  begin
    if reset = '1' then
      current_state <= idle;
      amount <= (others => '0');
      selected_price <= (others => '0');
      product_id <= (others => '0');
    elsif rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process;

  -- Next state logic
  process(current_state, product1, product2, product3, coin_10c, coin_20c, coin_50c, coin_1e, amount, selected_price)
  begin
    next_state <= current_state;

    case current_state is
      when idle =>
        if product1 = '1' then
          next_state <= product_select;
          product_id <= "01";
          selected_price <= P1_PRICE;
        elsif product2 = '1' then
          next_state <= product_select;
          product_id <= "10";
          selected_price <= P2_PRICE;
        elsif product3 = '1' then
          next_state <= product_select;
          product_id <= "11";
          selected_price <= P3_PRICE;
        end if;

      when product_select =>
        next_state <= insert_coin;

      when insert_coin =>
        -- Add coins if any button is pressed
        if coin_10c = '1' then
          amount <= amount + to_unsigned(10, 8);
        elsif coin_20c = '1' then
          amount <= amount + to_unsigned(20, 8);
        elsif coin_50c = '1' then
          amount <= amount + to_unsigned(50, 8);
        elsif coin_1e = '1' then
          amount <= amount + to_unsigned(100, 8);
        end if;

        if amount >= selected_price then
          next_state <= check;
        end if;

      when check =>
        if amount >= selected_price then
          next_state <= dispensing;
          amount <= amount - selected_price; -- Refund excess later
        else
          next_state <= insert_coin;
        end if;

      when dispensing =>
        next_state <= idle;

      when refunding =>
        next_state <= idle;

      when others =>
        next_state <= idle;
    end case;
  end process;

  -- Outputs
  dispense <= '1' when current_state = dispensing else '0';
  refund <= '1' when (amount > 0 and current_state = dispensing) else '0';

  -- 7-Segment Display (to be refined further)
  -- Placeholder: Show different messages based on state (e.g., P1-20, DISP, REF)
  -- Implement display decoder here...

end architecture;
