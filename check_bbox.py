"""Read country boundaries and print a bounding box

Usage:
    python check_bbox.py TZA
"""
import sys
import geopandas

def main(adm3):
    df = geopandas.read_file('ne_10m_admin_0_countries.shp')
    print(df[df.ADM0_A3 == adm3].reset_index(drop=True).bounds)

if __name__ == '__main__':
    main(sys.argv[1])
