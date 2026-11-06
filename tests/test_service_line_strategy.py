import unittest
from src.service_line_strategy_engine import run_pipeline


class TestServiceLineStrategyEngine(unittest.TestCase):
    def test_pipeline_metrics(self):
        summary = run_pipeline(seed=42)
        self.assertEqual(summary["combined_public_records_evaluated"], 68800)
        self.assertEqual(summary["service_lines_managed"], 6)
        self.assertGreater(summary["new_patient_acquisition_lift_pct"], 25.0)
        self.assertGreater(summary["wasted_ad_spend_reduction_pct"], 50.0)
        self.assertEqual(summary["mystery_shopping_audits_completed"], 2400)
        self.assertAlmostEqual(summary["blended_sports_sponsorship_roas"], 3.18, places=2)


if __name__ == "__main__":
    unittest.main()
