library IEEE;
use IEEE.std_logic_1164.all;

entity DM74LS153 is
    port (
        G1, G2 : in  std_logic;                  -- Enable for MUX1 and MUX2
        A, B   : in  std_logic;                  -- Selection inputs
        C1, C2 : in  std_logic_vector(3 downto 0); -- Data inputs for MUX1 and MUX2
        Y1, Y2 : out std_logic                   -- Outputs for MUX1 and MUX2
    );
end entity DM74LS153;

architecture df of DM74LS153 is
    signal sControl1, sControl2 : std_logic_vector(3 downto 0);
begin
    -- Control signals for MUX1 and MUX2 (active-low enable)
    sControl1 <= "0001" when A='0' and B='0' else
                 "0010" when A='1' and B='0' else
                 "0100" when A='0' and B='1' else
                 "1000";

    sControl2 <= "0001" when A='0' and B='0' else
                 "0010" when A='1' and B='0' else
                 "0100" when A='0' and B='1' else
                 "1000";

    -- First multiplexer
    with sControl1 select
        Y1 <= C1(0) when "0001",
              C1(1) when "0010",
              C1(2) when "0100",
              C1(3) when "1000",
              '0'   when others;

    -- Second multiplexer
    with sControl2 select
        Y2 <= C2(0) when "0001",
              C2(1) when "0010",
              C2(2) when "0100",
              C2(3) when "1000",
              '0'   when others;
end architecture df;

architecture behv of DM74LS153 is
begin
    -- Process for first multiplexer
    process(G1, A, B, C1)
    begin
        if G1 = '1' then
            Y1 <= '0' after 22 ns;
        else
            case (A & B) is
                when "00" => Y1 <= C1(0) after 22 ns;
                when "01" => Y1 <= C1(1) after 22 ns;
                when "10" => Y1 <= C1(2) after 22 ns;
                when "11" => Y1 <= C1(3) after 22 ns;
                when others => Y1 <= '0' after 22 ns;
            end case;
        end if;
    end process;

    -- Process for second multiplexer
    process(G2, A, B, C2)
    begin
        if G2 = '1' then
            Y2 <= '0' after 22 ns;
        else
            case (A & B) is
                when "00" => Y2 <= C2(0) after 22 ns;
                when "01" => Y2 <= C2(1) after 22 ns;
                when "10" => Y2 <= C2(2) after 22 ns;
                when "11" => Y2 <= C2(3) after 22 ns;
                when others => Y2 <= '0' after 22 ns;
            end case;
        end if;
    end process;
end architecture behv;

architecture struct of DM74LS153 is
    component MUX4
        port (
            A, B, G  : in  std_logic;
            C        : in  std_logic_vector(3 downto 0);
            Y        : out std_logic
        );
    end component;

begin
    -- Instantiate first MUX
    MUX1_INST: MUX4
        port map (
            A => A,
            B => B,
            G => G1,
            C => C1,
            Y => Y1
        );

    -- Instantiate second MUX
    MUX2_INST: MUX4
        port map (
            A => A,
            B => B,
            G => G2,
            C => C2,
            Y => Y2
        );
end architecture struct;
