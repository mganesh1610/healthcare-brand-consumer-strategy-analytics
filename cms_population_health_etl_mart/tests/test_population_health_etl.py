#!/usr/bin/env python3
"""Unit and boundary tests for the CDC PLACES Population Health T-SQL/SSIS/Power BI/SSRS Mart."""
from __future__ import annotations

from pathlib import Path
import sys
import unittest

MOD_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(MOD_DIR))

import population_health_etl as phe  # noqa: E402


class TestPopulationHealthETLMart(unittest.TestCase):
    def test_preventive_adherence_inversion_and_quarantine(self) -> None:
        sample = [
            {
                "year": "2023",
                "stateabbr": "AZ",
                "statedesc": "Arizona",
                "locationname": "Maricopa",
                "locationid": "04013",
                "category": "Prevention",
                "categoryid": "PREVENT",
                "measure": "Cervical cancer screening among adult women aged 21-65 years",
                "measureid": "CERVICAL",
                "datavaluetypeid": "CrdPrv",
                "data_value": "78.4",
                "low_confidence_limit": "75.1",
                "high_confidence_limit": "81.2",
                "totalpopulation": "4586431",
            },
            {
                "year": "2023",
                "stateabbr": "AZ",
                "statedesc": "Arizona",
                "locationname": "Pima",
                "locationid": "04019",
                "category": "Health Outcomes",
                "categoryid": "HLTHOUT",
                "measure": "Diagnosed diabetes among adults",
                "measureid": "DIABETES",
                "datavaluetypeid": "CrdPrv",
                "data_value": "",
                "totalpopulation": "1063162",
            },
            {
                "year": "2023",
                "stateabbr": "AZ",
                "statedesc": "Arizona",
                "locationname": "Yuma",
                "locationid": "04027",
                "category": "Health Outcomes",
                "categoryid": "HLTHOUT",
                "measure": "Diagnosed diabetes among adults",
                "measureid": "DIABETES",
                "datavaluetypeid": "CrdPrv",
                "data_value": "14.0",
                "low_confidence_limit": "18.0",
                "high_confidence_limit": "19.0",
                "totalpopulation": "213849",
            },
        ]
        promoted, quarantined = phe.parse_and_validate_cdc_records(sample)
        self.assertEqual(len(promoted), 1)
        self.assertAlmostEqual(promoted[0]["standardized_care_gap_pct"], 21.6, places=2)
        self.assertEqual(len(quarantined), 2)

    def test_star_schema_conservation_and_gates(self) -> None:
        sample = [
            {
                "year": "2023",
                "stateabbr": f"S{i % 6}",
                "statedesc": f"State {i % 6}",
                "locationname": f"County {i % 10}",
                "locationid": f"{10000 + (i % 10)}",
                "category": "Prevention" if i % 2 == 0 else "Health Outcomes",
                "categoryid": "PREVENT" if i % 2 == 0 else "HLTHOUT",
                "measure": f"Measure {i % 26}",
                "measureid": f"M{i % 26:02d}",
                "datavaluetypeid": "CrdPrv",
                "data_value": "72.5",
                "low_confidence_limit": "70.0",
                "high_confidence_limit": "75.0",
                "totalpopulation": "150000",
            }
            for i in range(1200)
        ]
        promoted, quarantined = phe.parse_and_validate_cdc_records(sample)
        gates, pbi, ssrs = phe.build_star_schema_and_audit(promoted, quarantined, len(sample))
        self.assertTrue(all(g["passed"] for g in gates), msg=f"Failed gates: {[g for g in gates if not g['passed']]}")
        self.assertGreater(len(pbi), 0)
        self.assertGreater(len(ssrs), 0)


if __name__ == "__main__":
    unittest.main()
