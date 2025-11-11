architecture behv of DM74LS153 is
begin

    ----------------------------------------------------------------
    -- Process for the first 4-to-1 multiplexer
    ----------------------------------------------------------------
    process (A, B, G1, C1)
    begin
        if G1 = '0' then  -- enabled
            case (B & A) is
                when "00" => Y1 <= C1(0) after 22 ns;
                when "01" => Y1 <= C1(1) after 22 ns;
                when "10" => Y1 <= C1(2) after 22 ns;
                when "11" => Y1 <= C1(3) after 22 ns;
                when others => Y1 <= '0' after 22 ns;
            end case;
        else
            Y1 <= '0' after 22 ns;  -- disabled
        end if;
    end process;

    ----------------------------------------------------------------
    -- Process for the second 4-to-1 multiplexer
    ----------------------------------------------------------------
    process (A, B, G2, C2)
    begin
        if G2 = '0' then  -- enabled
            case (B & A) is
                when "00" => Y2 <= C2(0) after 22 ns;
                when "01" => Y2 <= C2(1) after 22 ns;
                when "10" => Y2 <= C2(2) after 22 ns;
                when "11" => Y2 <= C2(3) after 22 ns;
                when others => Y2 <= '0' after 22 ns;
            end case;
        else
            Y2 <= '0' after 22 ns;  -- disabled
        end if;
    end process;

end architecture behv;
