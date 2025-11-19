--  4-to-1 Multiplexer (MUX4)
--  Structural model built from INV, AND4, and OR4 components
entity MUX4 is
    port (
        A, B, G  : in  std_logic;                  -- Select lines A,B and active-LOW enable G
        C        : in  std_logic_vector(3 downto 0); -- Data inputs (C0–C3)
        Y        : out std_logic                  -- Output
    );
end entity MUX4;

--  Structural architecture
--  Implements MUX using NOT, AND, and OR gates
architecture struct of MUX4 is

    -- Component declarations
    component INV
        port (A : in std_logic; Y : out std_logic);
    end component;

    component AND4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    component OR4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    -- Internal signals for inverted control lines
    signal nA, nB, nG : std_logic;

    -- Outputs from each of the four AND gates
    signal y0, y1, y2, y3 : std_logic;

begin
    
    -- Invert select inputs and enable
    U1: INV port map (A => A, Y => nA);   -- nA = NOT A
    U2: INV port map (A => B, Y => nB);   -- nB = NOT B
    U3: INV port map (A => G, Y => nG);   -- nG = NOT G (since G is active-LOW)

    -- AND gates generate one-hot selection of data inputs
    -- Only one AND gate becomes active for each A,B
    AND0: AND4 port map (A => nG, B => nB, C => nA, D => C(0), Y => y0); -- Select C0
    AND1: AND4 port map (A => nG, B => nB, C => A,  D => C(1), Y => y1); -- Select C1
    AND2: AND4 port map (A => nG, B => B,  C => nA, D => C(2), Y => y2); -- Select C2
    AND3: AND4 port map (A => nG, B => B,  C => A,  D => C(3), Y => y3); -- Select C3

    -- OR gate combines the AND outputs into final result
    -- Exactly one AND gate contributes when enabled
    ORMUX: OR4 port map (A => y0, B => y1, C => y2, D => y3, Y => Y);

end architecture struct;
