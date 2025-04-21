import 'district.dart';

final Map<String, String> divisionMap = {
  'ঢাকা': 'f47ea481-c504-4dc6-9bf5-350bbb200719',
  'চট্টগ্রাম': '2be20dd7-39d9-4cc3-bfaa-f13761210051',
  'বরিশাল': 'a0a290a7-4f6f-4e21-8550-58f45cc122d8',
  'খুলনা': 'cd7e4fe4-9e2d-452c-96ae-6632bd4069ed',
  'ময়মনসিংহ': '3ec0a8e8-7552-4a23-8774-07702414d2cb',
  'রাজশাহী': 'b65f7d01-b5f9-4bd6-a124-4b7bb6d13641',
  'রংপুর': '8d02cf87-d0db-4112-b961-dcaceb68c084',
  'সিলেট': '9d15504f-4f19-4403-b2c3-ed686797864c',
};

final Map<String, List<District>> divisionDistrictsMap = {
  // বরিশাল বিভাগ
  divisionMap['বরিশাল']!: [
    District(id: '80dc1b41-f32f-414f-aaa6-63354000549b', name: 'বরিশাল'),
    District(id: '2a4c157a-0016-476c-bd65-3d14b519ea10', name: 'বরগুনা'),
    District(id: '9626d329-58c3-4ccd-8260-679e5a61b74b', name: 'ভোলা'),
    District(id: '198d591d-2ab6-4093-a687-b6979e9941e0', name: 'ঝালকাঠি'),
    District(id: '78c4180f-d9c5-40be-8d1d-f60fc91af586', name: 'পটুয়াখালী'),
    District(id: 'e12bcfef-1ccc-4012-8eda-08e222965fbd', name: 'পিরোজপুর'),
  ],

  // চট্টগ্রাম বিভাগ
  divisionMap['চট্টগ্রাম']!: [
    District(
      id: '31e97adf-159f-42a7-ad59-af8f72fa0eab',
      name: 'ব্রাহ্মণবাড়িয়া',
    ),
    District(id: 'f5c95e6f-d8a4-477f-8bd6-4e33a8e8739c', name: 'কুমিল্লা'),
    District(id: 'e7b5abeb-f5b5-43d3-84c3-0c7f56cb6dda', name: 'চাঁদপুর'),
    District(id: '0290ea70-ce3f-427f-addc-429345825f34', name: 'লক্ষ্মীপুর'),
    District(id: 'b14d0d4b-750c-420e-8ec4-0f45e168493c', name: 'নোয়াখালী'),
    District(id: '582b0c08-573a-437b-a4e9-24d85b65ef2e', name: 'ফেনী'),
    District(id: '8ea331d3-779e-4c37-8db9-56426187ef23', name: 'খাগড়াছড়ি'),
    District(id: '045ac952-92a6-4272-8bb8-d5d06996520b', name: 'রাঙ্গামাটি'),
    District(id: '1838bb2e-2afa-4b39-80e2-9b6faffd2e14', name: 'বন্দরবান'),
    District(id: '1fbd0359-d3d1-4a46-8eae-5ecb897b4d2c', name: 'চট্টগ্রাম'),
    District(id: 'b826a067-7c91-48b5-99b7-aa3d0498a243', name: 'কক্সবাজার'),
  ],

  // ঢাকা বিভাগ
  divisionMap['ঢাকা']!: [
    District(id: '0bc234e0-3bf7-40bb-beb2-97de020d2468', name: 'ঢাকা'),
    District(id: '08c5efa8-4fec-42b5-bc65-d6cf74fe07ea', name: 'গাজীপুর'),
    District(id: '3eb69540-c877-4f09-831b-78b9dd962be0', name: 'কিশোরগঞ্জ'),
    District(id: '230d12d3-f3bc-4ba9-a2dc-7db16b063798', name: 'মানিকগঞ্জ'),
    District(id: '06416f7a-d867-425a-a50f-1b8da64e09f9', name: 'মুন্সিগঞ্জ'),
    District(id: 'c9f1e1b6-bab6-4e87-890f-fe43080cb250', name: 'নারায়ণগঞ্জ'),
    District(id: '25d9a8be-559b-4ea7-9ec6-58eccf51a161', name: 'নরসিংদি'),
    District(id: '8c1321a8-4164-4097-9b3a-39f100082f15', name: 'টাঙ্গাইল'),
    District(id: 'd4e5d5d5-97e9-4b80-936a-1a336139a9da', name: 'ফরিদপুর'),
    District(id: '203839ad-5541-4e5f-8912-cd61b8c71023', name: 'গোপালগঞ্জ'),
    District(id: 'ae728fae-8127-4009-b932-e8c592bb5e31', name: 'মাদারীপুর'),
    District(id: '1728e448-5d7c-48e9-81dc-075b03a42878', name: 'রাজবাড়ি'),
    District(id: '30ddde4c-5cca-4dba-856c-5366b8616746', name: 'শরীয়তপুর'),
  ],

  // খুলনা বিভাগ
  divisionMap['খুলনা']!: [
    District(id: '2806e73e-b618-40f2-8b99-b880a423e6f7', name: 'খুলনা'),
    District(id: '63756d04-d2b8-4e6e-a411-5284ce7ca36c', name: 'সাতক্ষীরা'),
    District(id: '48a83988-029a-4cdb-aa0a-f34304fdfbdd', name: 'যশোর'),
    District(id: 'ce22cd15-01ef-467a-a827-028b24194e78', name: 'চুয়াডাঙ্গা'),
    District(id: '6030b724-4063-4f99-830a-fb0c2109a8ad', name: 'ঝিনাইদহ'),
    District(id: 'df8d3748-b00c-4dd0-adfa-593417c5709d', name: 'কুষ্টিয়া'),
    District(id: 'e0a88ac7-9f7a-489a-bae8-b87140d4e493', name: 'মাগুরা'),
    District(id: '833fc003-04c6-47b7-a916-b873dcbd9e40', name: 'মেহেরপুর'),
    District(id: 'a07a8990-278d-4360-afb3-116b72f2e7da', name: 'নড়াইল'),
    District(id: '9fbe2a17-715d-4a5c-820c-f98dc3f3aadb', name: 'বাগেরহাট'),
  ],

  // ময়মনসিংহ বিভাগ
  divisionMap['ময়মনসিংহ']!: [
    District(id: '82e2e447-c54c-4022-b677-baed010eeb20', name: 'ময়মনসিংহ'),
    District(id: '7a88bf80-344d-4be2-88ed-b6e2526d82a0', name: 'জামালপুর'),
    District(id: '4404d9c9-8968-4d62-bb4a-5444c6aec358', name: 'নেত্রকোনা'),
    District(id: 'df9181c3-f509-4dfe-ba9e-fa5559d1fbfa', name: 'শেরপুর'),
  ],

  // রাজশাহী বিভাগ
  divisionMap['রাজশাহী']!: [
    District(id: '5a41c5ff-27eb-4832-bea4-437db20d2c2c', name: 'নাটোর'),
    District(id: '4e904d43-2799-4a4f-9e23-f2cb32ae0199', name: 'রাজশাহী'),
    District(id: '1bb79c90-a70d-432e-80ee-9d4e0e32a820', name: 'সিরাজগঞ্জ'),
    District(id: '26f185f7-5b54-4c0e-b496-b19a53e98383', name: 'পাবনা'),
    District(id: '9bc9fcf9-a8ae-446b-ad57-ef4dd2c7399d', name: 'বগুড়া'),
    District(id: '6792a399-f5fe-4ed0-8352-3acf12283f99', name: 'চাপাইনবাবগঞ্জ'),
    District(id: '2d8442fa-17a5-4696-a811-c9488ee14eca', name: 'নওগাঁ'),
    District(id: '27ece738-b583-4950-83a1-4c2a83415f4c', name: 'জয়পুরহাট'),
  ],

  // রংপুর বিভাগ
  divisionMap['রংপুর']!: [
    District(id: '36b45df7-7a04-4bff-bd94-51f7513dfd17', name: 'দিনাজপুর'),
    District(id: '8314769a-699f-453d-9bf4-2cf5d4b47bbc', name: 'কুড়িগ্রাম'),
    District(id: 'db24d25d-e2af-4794-952b-bd99ae3070bb', name: 'গাইবান্ধা'),
    District(id: '2de7ee96-e7d9-494a-a2df-03106d74a279', name: 'লালমনিরহাট'),
    District(id: '95163516-8f2f-41ee-8a70-c97142b35475', name: 'নিলফামারি'),
    District(id: 'd5b09373-4def-4336-b228-92218ae18c50', name: 'পঞ্চগড়'),
    District(id: '933758b9-f830-4425-be3f-152cdb07d715', name: 'রংপুর'),
    District(id: '16b7f796-98fa-4643-a2d6-c27c82aafdce', name: 'ঠাকুরগাঁও'),
  ],

  // সিলেট বিভাগ
  divisionMap['সিলেট']!: [
    District(id: 'e2c6d245-9eeb-4c84-a2b0-050548f77351', name: 'হবিগঞ্জ'),
    District(id: 'e1f0ea51-82ee-4369-a894-b9daba60087c', name: 'মৌলভীবাজার'),
    District(id: '583085fd-be05-4e93-845c-fde8dbec0ede', name: 'সুনামগঞ্জ'),
    District(id: 'bddd5326-2f95-4a8f-991a-c24125cc6b22', name: 'সিলেট'),
  ],
};
