entity LED_on is
    port(LED : out bit);
end LED_on;

architecture behavior of LED_on is
begin
    LED <= '1';  -- ?? LED?????
end behavior;

