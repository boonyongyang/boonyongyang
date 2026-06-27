import math, os
from PIL import Image, ImageDraw, ImageFont

def render_donut(A, B, cols=60, rows=18):
    output = [' '] * (cols * rows)
    z = [0.0] * (cols * rows)
    CHARS = '.,-~:;=!*#$@'
    theta = 0.0
    while theta < 6.284:
        phi = 0.0
        while phi < 6.284:
            sinA, cosA = math.sin(A), math.cos(A)
            sinB, cosB = math.sin(B), math.cos(B)
            cosT, sinT = math.cos(theta), math.sin(theta)
            cosP, sinP = math.cos(phi), math.sin(phi)
            h = cosT + 2
            D = 1.0 / (sinP * h * sinA + sinT * cosA + 5)
            t = sinP * h * cosA - sinT * sinA
            xp = int(cols / 2 + 22 * D * (cosP * h * cosB - t * sinB))
            yp = int(rows / 2 + 9 * D * (cosP * h * sinB + t * cosB))
            o = xp + cols * yp
            N = int(8 * ((sinT * sinA - sinP * cosT * cosA) * cosB - sinP * cosT * sinA - sinT * cosA - cosP * cosT * sinB))
            if 0 < yp < rows and 0 < xp < cols and D > z[o]:
                z[o] = D
                output[o] = CHARS[max(0, min(N, 11))]
            phi += 0.02
        theta += 0.07
    return [''.join(output[r * cols:(r + 1) * cols]) for r in range(rows)]

A, B = 0.0, 0.0
all_frames = []
for _ in range(60):
    all_frames.append(render_donut(A, B))
    A += 0.08
    B += 0.03

FONT_SIZE = 16
char_w, char_h = 10, 18
cols, rows = 60, 18
img_w = cols * char_w
img_h = rows * char_h

font = None
for path in [
    "/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf",
    "/usr/share/fonts/truetype/liberation/LiberationMono-Regular.ttf",
    "/usr/share/fonts/TTF/DejaVuSansMono.ttf",
]:
    try:
        font = ImageFont.truetype(path, FONT_SIZE)
        print(f"Loaded font: {path}")
        break
    except Exception:
        pass
if font is None:
    print("WARNING: Using default bitmap font")
    font = ImageFont.load_default()

os.makedirs('assets', exist_ok=True)

THEMES = [
    ("donut-dark.gif",  (13, 17, 23),   (233, 69, 96)),
    ("donut-light.gif", (255, 255, 255), (176, 16, 48)),
]

for filename, BG, FG in THEMES:
    frames = []
    for frame_lines in all_frames:
        img = Image.new('RGB', (img_w, img_h), BG)
        draw = ImageDraw.Draw(img)
        for row_idx, line in enumerate(frame_lines):
            for col_idx, ch in enumerate(line):
                if ch != ' ':
                    draw.text((col_idx * char_w, row_idx * char_h), ch, fill=FG, font=font)
        frames.append(img)

    frames[0].save(
        f'assets/{filename}',
        save_all=True,
        append_images=frames[1:],
        duration=55,
        loop=0,
    )
    print(f"Saved: assets/{filename} ({img_w}x{img_h}, {len(frames)} frames)")
