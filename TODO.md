# TODO: Implement Job Activation Workflow

## 1. Modify Job Upload Logic
- [x] Update job upload process to set `isActive = false` by default when a job is created/uploaded.
- [x] Locate and modify the job upload screen/service in `lib/Feature/Recuiter/`.


## 2. Add Firebase Methods for Admin
- [ ] Add method in `JobRepository` (`firebase_jobs.dart`) to fetch all jobs for a specific recruiter (regardless of `isActive`).
- [ ] Add method to update a job's `isActive` status (activate/deactivate).

## 3. Update Admin Screens
- [ ] In `admindashboard_screen.dart`: Ensure recruiters are listed.
- [ ] In `recuiterlist_screen.dart`: When tapping a recruiter card, display their jobs (show inactive ones with an "Activate" button).
- [ ] Add tap handler to activate a job (call the update method).

## 4. Update Recruiter Screens
- [ ] In recruiter job list screen (likely in `lib/Feature/Recuiter/jobseekers_screens/`): Display jobs without an activate button.
- [ ] Add longpress to delete jobs.

## 5. Testing
- [ ] Test full flow: Upload job (inactive), admin sees and activates, jobseeker sees active job.
- [ ] Verify recruiter can only delete via longpress.
