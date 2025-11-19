--  4-Input AND Gate (AND4)
entity AND4 is
    port (
        A, B, C, D : in  std_logic;   -- Four input signals
        Y          : out std_logic    -- Output = A AND B AND C AND D
    );
end entity AND4;

--  Behavioral architecture with propagation delay
architecture behv of AND4 is
begin
    -- Output Y goes HIGH only when all inputs are '1'
    -- Propagation delay modeled as 7 ns
    Y <= (A and B and C and D) after 7 ns;
end architecture behv;
