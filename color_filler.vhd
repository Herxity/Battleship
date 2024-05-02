----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2024 04:26:42 PM
-- Design Name: 
-- Module Name: color_filler - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity color_filler is
    generic (
        bus_width : integer := 6;
        sel_width : integer := 6
    );
    Port ( clk, en,vid :in std_logic;
         hcount,vcount:in std_logic_vector(9 downto 0);
         Rout,Bout: out std_logic_vector(3 downto 0);
         Gout: out std_logic_vector( 3 downto 0);
         grid : in std_logic_vector((sel_width * bus_width) - 1 downto 0)
        );
end color_filler;

architecture Behavioral of color_filler is

    signal x, y : integer:=0;
    signal hcounter,vcounter: std_logic_vector(9 downto 0):= (others => '0');
    signal idx : integer:=0;
    signal counter : integer:=0;
begin
    incremeter: process(clk)
    begin
        if rising_edge(clk) then
            if(counter < 20000000) then
                counter <= counter + 1;
            else
                counter <= 0;
                idx <= idx + 1;
                if(idx = 35) then
                    idx <= 0;
                end if;
            end if;
        end if;
    end process;

    grid_counter: process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' and vid = '1' then
                -- Grid Tracking system
                if (unsigned(hcounter) <= 599) and (unsigned(vcounter) <= 479) then
                    if (unsigned(hcounter) mod 100 = 98) then
                        x <= x+1;
                        if(x = (bus_width-1)) then
                            x <= 0;
                        end if;

                    end if;
                    if (unsigned(hcounter) = 1 and unsigned(vcounter) mod 80 = 0 and unsigned(vcounter)> 79 ) then
                        y <= y+1;
                        if(y = (sel_width-1)) then
                            y <= 0;
                        end if;
                    end if;
                end if;

                if(((y)*6) + x = idx) then
                    Rout<= "1111";
                    Gout <= "0000";
                    Bout <= "0000";
                else
                    Rout<= "0000";
                    Gout <= "0000";
                    Bout <= "1111";
                end if;
            end if;
            if(en = '1') then
                if(vid = '0') then
                    x <=0;
                    if(unsigned(vcount)=490) then
                        y<=0;
                    end if;
                end if;
                --This occurs after every
                if (unsigned(hcounter) = 641) and (unsigned(vcounter) = 479) then
                    y <= y+1;
                    if(y = (sel_width-1)) then
                        y <= 0;
                    end if;
                end if;

            end if;
        end if;
    end process;

    hcounter <= hcount;
    vcounter <= vcount;
end Behavioral;
