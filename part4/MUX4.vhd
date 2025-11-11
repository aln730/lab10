entity MUX4 is
    port (
        A, B, G  : in  std_logic;
        C        : in  std_logic_vector(3 downto 0);
        Y        : out std_logic
    );
end entity MUX4;

architecture struct of MUX4 is
    component INV
        port (A : in std_logic; Y : out std_logic);
    end component;

    component AND4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    component OR4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    signal nA, nB, nG : std_logic;
    signal y0, y1, y2, y3 : std_logic;
begin
    -- Inverters
    U1: INV port map (A => A, Y => nA);
    U2: INV port map (A => B, Y => nB);
    U3: INV port map (A => G, Y => nG);

    -- AND gates for each data line
    AND0: AND4 port map (A => nG, B => nB, C => nA, D => C(0), Y => y0);
    AND1: AND4 port map (A => nG, B => nB, C => A,  D => C(1), Y => y1);
    AND2: AND4 port map (A => nG, B => B,  C => nA, D => C(2), Y => y2);
    AND3: AND4 port map (A => nG, B => B,  C => A,  D => C(3), Y => y3);

    -- OR gate combines all four
    ORMUX: OR4 port map (A => y0, B => y1, C => y2, D => y3, Y => Y);
end architecture struct;

