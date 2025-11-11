architecture struct of DM74LS153 is
    component MUX4
        port (
            A, B, G  : in  std_logic;
            C        : in  std_logic_vector(3 downto 0);
            Y        : out std_logic
        );
    end component;
begin
    -- First multiplexer
    MUX1: MUX4 port map (A => A, B => B, G => G1, C => C1, Y => Y1);

    -- Second multiplexer
    MUX2: MUX4 port map (A => A, B => B, G => G2, C => C2, Y => Y2);
end architecture struct;

