----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 05:51:51 PM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher is
    Port ( clk, en,vs,vid :in std_logic;
         hcount,vcount:in std_logic_vector(9 downto 0);
         R,B: out std_logic_vector(4 downto 0);
         G: out std_logic_vector( 5 downto 0)

        );
end pixel_pusher;

architecture Behavioral of pixel_pusher is
    signal hcounter,vcounter: std_logic_vector(9 downto 0):= (others => '0');
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if (en = '1') then
                if (vid = '1') then
                    if ((unsigned(hcounter)) <= 639) and ((unsigned(vcounter)) <= 479) then
                        if ((unsigned(vcounter)) mod 91 = 0 or (unsigned(hcounter)) mod 91 = 0) then
                            R <= "11111"; -- White Lines
                            G <= "111111";
                            B <= "11111";
                        else
                            R <= "00000";
                            G <= "000000";
                            B <= "11111"; -- Blue box
                        end if;
                        -- Draw letters
                        if ((unsigned(vcounter)) >= 200) and ((unsigned(vcounter)) <= 280) and (unsigned(hcounter)) >= 200 and (unsigned(hcounter)) <= 280 then
                            case (to_integer(unsigned(vcounter))) is
                                when (221) | (241) | (261) =>
                                    case (to_integer(unsigned(hcounter))) is
                                        when 211 | 241 =>
                                            R <= "11111"; -- White 
                                            G <= "111111";
                                            B <= "11111";
                                        when 221 =>
                                            if (unsigned(hcounter)) <= 241 then
                                                R <= "11111";
                                                G <= "111111";
                                                B <= "11111";
                                            end if;
                                        when 231 =>
                                            if (unsigned(hcounter)) >= 211 then
                                                R <= "11111";
                                                G <= "111111";
                                                B <= "11111";
                                            end if;
                                        when 251 =>
                                            if (unsigned(hcounter)) <= 241 then
                                                R <= "11111";
                                                G <= "111111";
                                                B <= "11111";
                                            end if;
                                        when 261 =>
                                            if (unsigned(hcounter)) >= 211 then
                                                R <= "11111";
                                                G <= "111111";
                                                B <= "11111";
                                            end if;
                                        when 271 | 281 =>
                                            R <= "11111";
                                            G <= "111111";
                                            B <= "11111";
                                        when others =>
                                            R <= (others => '0');
                                            G <= (others => '0');
                                            B <= (others => '0');
                                    end case;
                                when others =>
                                    R <= (others => '0');
                                    G <= (others => '0');
                                    B <= (others => '0');
                            end case;
                        end if;
                    else
                        R <= "00000";
                        G <= "000000";
                        B <= "00000";
                    end if;

                end if;
            end if;
        end if;

    end process;

    hcounter <= hcount;
    vcounter <= vcount;




end Behavioral;
