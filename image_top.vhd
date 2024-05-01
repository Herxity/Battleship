----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 06:48:15 PM
-- Design Name: 
-- Module Name: image_top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
    Port ( clk :in std_logic;
         hs,vs: out std_logic;
         R,B: out std_logic_vector(4 downto 0);
         G :out std_logic_vector(5 downto 0)

        );
end image_top;

architecture Behavioral of image_top is

    component clock_div
        Port (clk: in std_logic;
             en: out std_logic
            );
    end component clock_div;

    component pixel_pusher
        Port ( clk, en, vs, vid :in std_logic;
             hcount:in std_logic_vector(9 downto 0);
             vcount:in std_logic_vector(9 downto 0);
             R,B: out std_logic_vector(4 downto 0);
             G: out std_logic_vector( 5 downto 0)

            );
    end component pixel_pusher;

    component vga_ctrl
        Port ( clk, en: in std_logic;
             vid,vs,hs: out std_logic;
             hcount:out std_logic_vector(9 downto 0);
             vcount:out std_logic_vector(9 downto 0)
            );
    end component vga_ctrl;



    signal en, temp_vs, vid, clka: std_logic;
    signal hcount,vcount: std_logic_vector(9 downto 0);


begin
    vs <= temp_vs;


    p1: clock_div
        port map (
            clk => clk,
            en => en
        );



    p3: vga_ctrl
        port map(
            clk => clk,
            en => en,
            hs => hs,
            hcount => hcount,
            vcount => vcount,
            vid => vid,
            vs => temp_vs
        );

    p4: pixel_pusher
        port map(
            clk => clk,
            en => en,
            hcount => hcount,
            vcount => vcount,
            vid => vid,
            vs => temp_vs,
            R => R,
            G => G,
            B => B

        );


end Behavioral;
