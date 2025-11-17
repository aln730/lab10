library IEEE;
use IEEE.std_logic_1164.all;

entity tb_part1 is
end tb_part1;

architecture tb of tb_part1 is

    -- Testbench signals
    signal G1, G2 : std_logic := '0';
    signal A, B   : std_logic := '0';
    signal C1, C2 : std_logic_vector(3 downto 0) := (others => '0');

    -- Outputs for each architecture
    signal Y1_df,  Y2_df  : std_logic;
    signal Y1_behv, Y2_behv : std_logic;
    signal Y1_struct, Y2_struct : std_logic;

begin

    --------------------------------------------------------------------
    -- 3 INSTANCES IN PARALLEL
    --------------------------------------------------------------------

    dut_df: entity work.DM74LS153(df)
        port map (G1, G2, A, B, C1, C2, Y1_df, Y2_df);

    dut_behv: entity work.DM74LS153(behv)
        port map (G1, G2, A, B, C1, C2, Y1_behv, Y2_behv);

    dut_struct: entity work.DM74LS153(struct)
        port map (G1, G2, A, B, C1, C2, Y1_struct, Y2_struct);

    --------------------------------------------------------------------
    -- STIMULUS PROCESS
    --------------------------------------------------------------------
    stim_proc : process
    begin

        ----------------------------------------------------------------
        -- Test Set 1 (from the table)
        -- G B A C3 C2 C1 C0   — every vector lasts 100 ns
        ----------------------------------------------------------------

        -- Row 1
        G1 <= '0'; G2 <= '0';
        B <= '0'; A <= '0';
        C1 <= "1110"; C2 <= "1110";
        wait for 100 ns;

        -- Row 2
        C1 <= "0001"; C2 <= "0001";
        wait for 100 ns;

        -- Row 3
        A <= '1'; B <= '0';
        C1 <= "1101"; C2 <= "1101";
        wait for 100 ns;

        -- Row 4
        C1 <= "0010"; C2 <= "0010";
        wait for 100 ns;

        -- Row 5
        A <= '0'; B <= '1';
        C1 <= "1011"; C2 <= "1011";
        wait for 100 ns;

        -- Row 6
        C1 <= "0100"; C2 <= "0100";
        wait for 100 ns;

        -- Row 7
        A <= '1'; B <= '1';
        C1 <= "0111"; C2 <= "0111";
        wait for 100 ns;

        -- Row 8
        C1 <= "1000"; C2 <= "1000";
        wait for 100 ns;

        wait;
    end process;

end tb;
