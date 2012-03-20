#!/usr/bin/env ruby

# David Selassie
# March 19, 2012
# Extends the Color module from the color gem to add terminal color methods.

require 'rubygems'
require 'color'

module Color
    # Hex values for the 256 XTerm colors. Keys are those indexes.
    XTERM_TABLE = {
    0   => 0x000000, 1   => 0x800000, 2   => 0x008000, 3   => 0x808000,
    4   => 0x000080, 5   => 0x800080, 6   => 0x008080, 7   => 0xc0c0c0,
    8   => 0x808080, 9   => 0xff0000, 10  => 0x00ff00, 11  => 0xffff00,
    12  => 0x0000ff, 13  => 0xff00ff, 14  => 0x00ffff, 15  => 0xffffff,
    16  => 0x000000, 17  => 0x00005f, 18  => 0x000087, 19  => 0x0000af,
    20  => 0x0000df, 21  => 0x0000ff, 22  => 0x005f00, 23  => 0x005f5f,
    24  => 0x005f87, 25  => 0x005faf, 26  => 0x005fdf, 27  => 0x005fff,
    28  => 0x008700, 29  => 0x00875f, 30  => 0x008787, 31  => 0x0087af,
    32  => 0x0087df, 33  => 0x0087ff, 34  => 0x00af00, 35  => 0x00af5f,
    36  => 0x00af87, 37  => 0x00afaf, 38  => 0x00afdf, 39  => 0x00afff,
    40  => 0x00df00, 41  => 0x00df5f, 42  => 0x00df87, 43  => 0x00dfaf,
    44  => 0x00dfdf, 45  => 0x00dfff, 46  => 0x00ff00, 47  => 0x00ff5f,
    48  => 0x00ff87, 49  => 0x00ffaf, 50  => 0x00ffdf, 51  => 0x00ffff,
    52  => 0x5f0000, 53  => 0x5f005f, 54  => 0x5f0087, 55  => 0x5f00af,
    56  => 0x5f00df, 57  => 0x5f00ff, 58  => 0x5f5f00, 59  => 0x5f5f5f,
    60  => 0x5f5f87, 61  => 0x5f5faf, 62  => 0x5f5fdf, 63  => 0x5f5fff,
    64  => 0x5f8700, 65  => 0x5f875f, 66  => 0x5f8787, 67  => 0x5f87af,
    68  => 0x5f87df, 69  => 0x5f87ff, 70  => 0x5faf00, 71  => 0x5faf5f,
    72  => 0x5faf87, 73  => 0x5fafaf, 74  => 0x5fafdf, 75  => 0x5fafff,
    76  => 0x5fdf00, 77  => 0x5fdf5f, 78  => 0x5fdf87, 79  => 0x5fdfaf,
    80  => 0x5fdfdf, 81  => 0x5fdfff, 82  => 0x5fff00, 83  => 0x5fff5f,
    84  => 0x5fff87, 85  => 0x5fffaf, 86  => 0x5fffdf, 87  => 0x5fffff,
    88  => 0x870000, 89  => 0x87005f, 90  => 0x870087, 91  => 0x8700af,
    92  => 0x8700df, 93  => 0x8700ff, 94  => 0x875f00, 95  => 0x875f5f,
    96  => 0x875f87, 97  => 0x875faf, 98  => 0x875fdf, 99  => 0x875fff, 
    100 => 0x878700, 101 => 0x87875f, 102 => 0x878787, 103 => 0x8787af,
    104 => 0x8787df, 105 => 0x8787ff, 106 => 0x87af00, 107 => 0x87af5f,
    108 => 0x87af87, 109 => 0x87afaf, 110 => 0x87afdf, 111 => 0x87afff,
    112 => 0x87df00, 113 => 0x87df5f, 114 => 0x87df87, 115 => 0x87dfaf,
    116 => 0x87dfdf, 117 => 0x87dfff, 118 => 0x87ff00, 119 => 0x87ff5f,
    120 => 0x87ff87, 121 => 0x87ffaf, 122 => 0x87ffdf, 123 => 0x87ffff,
    124 => 0xaf0000, 125 => 0xaf005f, 126 => 0xaf0087, 127 => 0xaf00af,
    128 => 0xaf00df, 129 => 0xaf00ff, 130 => 0xaf5f00, 131 => 0xaf5f5f,
    132 => 0xaf5f87, 133 => 0xaf5faf, 134 => 0xaf5fdf, 135 => 0xaf5fff,
    136 => 0xaf8700, 137 => 0xaf875f, 138 => 0xaf8787, 139 => 0xaf87af,
    140 => 0xaf87df, 141 => 0xaf87ff, 142 => 0xafaf00, 143 => 0xafaf5f,
    144 => 0xafaf87, 145 => 0xafafaf, 146 => 0xafafdf, 147 => 0xafafff,
    148 => 0xafdf00, 149 => 0xafdf5f, 150 => 0xafdf87, 151 => 0xafdfaf,
    152 => 0xafdfdf, 153 => 0xafdfff, 154 => 0xafff00, 155 => 0xafff5f,
    156 => 0xafff87, 157 => 0xafffaf, 158 => 0xafffdf, 159 => 0xafffff,
    160 => 0xdf0000, 161 => 0xdf005f, 162 => 0xdf0087, 163 => 0xdf00af,
    164 => 0xdf00df, 165 => 0xdf00ff, 166 => 0xdf5f00, 167 => 0xdf5f5f,
    168 => 0xdf5f87, 169 => 0xdf5faf, 170 => 0xdf5fdf, 171 => 0xdf5fff,
    172 => 0xdf8700, 173 => 0xdf875f, 174 => 0xdf8787, 175 => 0xdf87af,
    176 => 0xdf87df, 177 => 0xdf87ff, 178 => 0xdfaf00, 179 => 0xdfaf5f,
    180 => 0xdfaf87, 181 => 0xdfafaf, 182 => 0xdfafdf, 183 => 0xdfafff,
    184 => 0xdfdf00, 185 => 0xdfdf5f, 186 => 0xdfdf87, 187 => 0xdfdfaf,
    188 => 0xdfdfdf, 189 => 0xdfdfff, 190 => 0xdfff00, 191 => 0xdfff5f,
    192 => 0xdfff87, 193 => 0xdfffaf, 194 => 0xdfffdf, 195 => 0xdfffff,
    196 => 0xff0000, 197 => 0xff005f, 198 => 0xff0087, 199 => 0xff00af,
    200 => 0xff00df, 201 => 0xff00ff, 202 => 0xff5f00, 203 => 0xff5f5f,
    204 => 0xff5f87, 205 => 0xff5faf, 206 => 0xff5fdf, 207 => 0xff5fff,
    208 => 0xff8700, 209 => 0xff875f, 210 => 0xff8787, 211 => 0xff87af,
    212 => 0xff87df, 213 => 0xff87ff, 214 => 0xffaf00, 215 => 0xffaf5f,
    216 => 0xffaf87, 217 => 0xffafaf, 218 => 0xffafdf, 219 => 0xffafff,
    220 => 0xffdf00, 221 => 0xffdf5f, 222 => 0xffdf87, 223 => 0xffdfaf,
    224 => 0xffdfdf, 225 => 0xffdfff, 226 => 0xffff00, 227 => 0xffff5f,
    228 => 0xffff87, 229 => 0xffffaf, 230 => 0xffffdf, 231 => 0xffffff,
    232 => 0x080808, 233 => 0x121212, 234 => 0x1c1c1c, 235 => 0x262626,
    236 => 0x303030, 237 => 0x3a3a3a, 238 => 0x444444, 239 => 0x4e4e4e,
    240 => 0x585858, 241 => 0x606060, 242 => 0x666666, 243 => 0x767676,
    244 => 0x808080, 245 => 0x8a8a8a, 246 => 0x949494, 247 => 0x9e9e9e,
    248 => 0xa8a8a8, 249 => 0xb2b2b2, 250 => 0xbcbcbc, 251 => 0xc6c6c6,
    252 => 0xd0d0d0, 253 => 0xdadada, 254 => 0xe4e4e4, 255 => 0xeeeeee
    }

    class RGB
        def to_xterm
            to_hsl.to_xterm
        end

        # Makes this color the terminal foreground color.
        def set_fg
            STDOUT.write "\033[38;5;#{to_xterm}m"
        end

        # Makes this color the terminal background color.
        def set_bg
            STDOUT.write "\033[48;5;#{to_xterm}m"
        end

        # Resets terminal to default colors.
        def reset
            STDOUT.write "\033[0m"
        end
    end

    class HSL
        # Returns the index of the closest XTerm color.
        def to_xterm
            closest_i = nil
            closest_dr = 255 * 3
            XTERM_TABLE.each_pair do |i, hex|
                r = (hex & 0xff0000) >> 16
                g = (hex & 0x00ff00) >> 8
                b = (hex & 0x0000ff)
                o = Color::RGB.new(r, g, b).to_hsl

                # Put extra weight on the hue.
                dr = (o.h - self.h).abs * 1.5
                    + (o.s - self.s).abs + (o.l - self.l).abs
                if dr < closest_dr then
                    closest_i = i
                    closest_dr = dr
                end
            end
            closest_i
        end
    end
end

class String
    # Call on a string to add the commands to color that string to it.
    def colored(i)
        if i.respond_to? :to_xterm then
            i = i.to_xterm
        end
        "\033[38;5;#{i}m" + self + "\033[0m"
    end
end
