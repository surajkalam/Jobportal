// job_data.dart
class Job {
  final String imagePath;
  final String designation;
  final String companyName;
  final String location;
  final String experience;
  final String ctc;

  Job({
    required this.imagePath,
    required this.designation,
    required this.companyName,
    required this.location,
    required this.experience,
    required this.ctc,
  });
}

class JobData {
  static List<Job> airlineJobs = [
    Job(
      imagePath: 'asset/images/accenture.png',
      designation: 'Senior Pilot',
      companyName: 'Air India',
      location: 'Mumbai',
      experience: '5+ years',
      ctc: '₹25-35 LPA',
    ),
    Job(
      imagePath: 'asset/images/airtel1.png',
      designation: 'Cabin Crew',
      companyName: 'IndiGo',
      location: 'Delhi',
      experience: '2+ years',
      ctc: '₹6-10 LPA',
    ),
    Job(
      imagePath: 'asset/images/accenture.png',
      designation: 'Ground Staff',
      companyName: 'Vistara',
      location: 'Bangalore',
      experience: '1+ years',
      ctc: '₹4-6 LPA',
    ),
    Job(
      imagePath: 'asset/images/accenture.png',
      designation: 'Air Traffic Controller',
      companyName: 'Airport Authority',
      location: 'Hyderabad',
      experience: '3+ years',
      ctc: '₹12-18 LPA',
    ),
    Job(
      imagePath: 'asset/images/accenture.png',
      designation: 'Aircraft Maintenance Engineer',
      companyName: 'SpiceJet',
      location: 'Chennai',
      experience: '4+ years',
      ctc: '₹15-22 LPA',
    ),
    Job(
      imagePath: 'asset/images/airtel1.png',
      designation: 'Airline Customer Service',
      companyName: 'Go First',
      location: 'Kolkata',
      experience: '1+ years',
      ctc: '₹3-5 LPA',
    ),
    Job(
      imagePath: 'asset/images/accenture.png',
      designation: 'Ticketing & Reservation Agent',
      companyName: 'Akasa Air',
      location: 'Pune',
      experience: '0-1 years',
      ctc: '₹3-4 LPA',
    ),
  ];

  static List<Job> hospitalityJobs = [
    Job(
      imagePath: 'asset/images/accenture.png',
      designation: 'Executive Chef',
      companyName: 'Taj Hotels',
      location: 'Mumbai',
      experience: '8+ years',
      ctc: '₹12-18 LPA',
    ),
    Job(
      imagePath: 'asset/images/accenture.png',
      designation: 'Hotel Manager',
      companyName: 'Marriott',
      location: 'Delhi',
      experience: '6+ years',
      ctc: '₹15-25 LPA',
    ),
    Job(
      imagePath: 'asset/images/airtel1.png',
      designation: 'Front Desk Executive',
      companyName: 'Hyatt',
      location: 'Goa',
      experience: '2+ years',
      ctc: '₹4-6 LPA',
    ),
  ];
}