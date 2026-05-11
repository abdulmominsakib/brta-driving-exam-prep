import 'package:flutter/material.dart';

import '../data/guides_data.dart';
import 'base_guide_page.dart';

class RegistrationGuidePage extends StatelessWidget {
  const RegistrationGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGuidePage(
      id: 'registration_process',
      title: 'নিবন্ধন প্রক্রিয়া',
      sections: GuidesData.getRegistrationProcess(),
      imagePath: 'assets/images/guides/registration_process.webp',
    );
  }
}

class LicenseRenewGuidePage extends StatelessWidget {
  const LicenseRenewGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGuidePage(
      id: 'license_renew',
      title: 'লাইসেন্স নবায়ন',
      sections: GuidesData.getLicenseRenew(),
      imagePath: 'assets/images/guides/license_renew.webp',
    );
  }
}

class TaxTokenRenewGuidePage extends StatelessWidget {
  const TaxTokenRenewGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGuidePage(
      id: 'tax_token_renew',
      title: 'ট্যাক্স টোকেন নবায়ন',
      sections: GuidesData.getTaxTokenRenew(),
      imagePath: 'assets/images/guides/tax_token_renew.webp',
    );
  }
}

class FitnessRenewGuidePage extends StatelessWidget {
  const FitnessRenewGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGuidePage(
      id: 'fitness_renew',
      title: 'ফিটনেস নবায়ন',
      sections: GuidesData.getFitnessRenew(),
      imagePath: 'assets/images/guides/fitness_renew.webp',
    );
  }
}

class OwnerChangeGuidePage extends StatelessWidget {
  const OwnerChangeGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGuidePage(
      id: 'owner_change',
      title: 'মালিকানা পরিবর্তন',
      sections: GuidesData.getOwnerChange(),
      imagePath: 'assets/images/guides/owner_change.webp',
    );
  }
}

class CarModificationGuidePage extends StatelessWidget {
  const CarModificationGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseGuidePage(
      id: 'car_modification',
      title: 'গাড়ি পরিবর্তন/পরিবর্ধন',
      sections: GuidesData.getCarModification(),
      imagePath: 'assets/images/guides/car_modification.webp',
    );
  }
}
