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
    generic (
        bus_width : integer := 6;
        sel_width : integer := 6
    );
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
        Port ( clk, en, vid :in std_logic;
             hcount:in std_logic_vector(9 downto 0);
             vcount:in std_logic_vector(9 downto 0);
             R,B: out std_logic_vector(4 downto 0);
             G: out std_logic_vector( 5 downto 0);
             Rin,Bin: in std_logic_vector(4 downto 0);
             Gin: in std_logic_vector( 5 downto 0)

            );
    end component pixel_pusher;

    component vga_ctrl
        Port ( clk, en: in std_logic;
             vid,vs,hs: out std_logic;
             hcount:out std_logic_vector(9 downto 0);
             vcount:out std_logic_vector(9 downto 0)
            );
    end component vga_ctrl;

    component color_filler
        Port ( clk, en,vid :in std_logic;
             hcount,vcount:in std_logic_vector(9 downto 0);
             Rout,Bout: out std_logic_vector(4 downto 0);
             Gout: out std_logic_vector( 5 downto 0);
             grid : in std_logic_vector((sel_width * bus_width) - 1 downto 0)
            );
    end component color_filler;



    signal en, temp_vs, vid: std_logic;
    signal hcount,vcount: std_logic_vector(9 downto 0);
signal R_sig,B_sig: std_logic_vector(4 downto 0);
signal G_sig: std_logic_vector(5 downto 0);
signal grid : std_logic_vector((sel_width * bus_width) - 1 downto 0) := (others => '0');


begin
    vs <= temp_vs;


    p1: clock_div
        port map (
            clk => clk,
            en => en
        );

    p2: color_filler
        port map(
            clk => clk,
            en => en,
            hcount => hcount,
            vcount => vcount,
            vid => vid,
            Rout => R_sig,
            Bout => B_sig,
            Gout => G_sig,
            Grid => grid
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
            R => R,
            G => G,
            B => B,
            Rin => R_sig,
            Gin => G_sig,
            Bin => B_sig
        );


end Behavioral;
