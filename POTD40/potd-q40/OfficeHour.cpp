#include "OfficeHour.h"
#include <iostream>
#include <map>

/*
Given the current Office Hour queue and the currently on-duty staffers, return
how long the nth student will need to wait before a Staffer can reach them
Return -1 if there are no staff available to help the nth student

@param queue A queue containing the students currently waiting for help
@param onDutyStaff  A vector of Staffers currently on duty
@param nthStudent   The student for whom we are calculating a wait time
@return             How many minutes the nth student will have to wait before
getting help
*/

int takeStudent(Student& student, std::vector<Staffer>& staff,
                std::vector<int>& end_time, int mins) {
  //   for (unsigned i = 0; i < end_time.size(); i++) {
  //     std::cout << "end_time[" << i << "] = " << end_time[i] << std::endl;
  //   }

  for (unsigned s = 0; s < staff.size(); s++) {
    Staffer& st = staff[s];
    int energy = st.getEnergyLevel();
    if ((energy > 0) && (end_time[s] <= mins)) {
      end_time[s] = mins + st.answerQuestion(student.getQuestionType(),
                                             student.getTimeNeeded());

      //   std::cout << "Staffer " << s << " now answering till " << end_time[s]
      //             << " energy: " << st.getEnergyLevel() << std::endl;
      return s;
    }
  }

  return -1;
}

int waitTime(queue<Student> queue, vector<Staffer> onDutyStaff,
             int nthStudent) {
  if (onDutyStaff.size() == 0) return -1;

  vector<bool> free;
  vector<int> end_time;
  for (auto s : onDutyStaff) {
    free.push_back(true);
    end_time.push_back(0);
  }

  int count = 1;
  Student curStudent = queue.front();
  while (count < nthStudent) {
    curStudent = queue.front();
    queue.pop();

    int idx = -1;
    int time = -1;

    for (unsigned i = 0; i < onDutyStaff.size(); i++) {
      if (onDutyStaff[i].getEnergyLevel() > 0) {
        idx = i;
        time = end_time[i];
        break;
      }
      if ((i == onDutyStaff.size() - 1) && idx == -1) {
        return -1;
      }
    }

    for (unsigned i = idx; i < onDutyStaff.size(); i++) {
      if (end_time[i] < time && onDutyStaff[i].getEnergyLevel() > 0) {
        time = end_time[i];
        idx = i;
      }
    }
    int timeNeeded = onDutyStaff[idx].answerQuestion(
        curStudent.getQuestionType(), curStudent.getTimeNeeded());
    end_time[idx] += timeNeeded;
    count++;
  }

  int answer = -1;

  for (unsigned i = 0; i < onDutyStaff.size(); i++) {
    if (onDutyStaff[i].getEnergyLevel() > 0) {
      answer = end_time[i];
      break;
    }
    if ((i == onDutyStaff.size() - 1) && answer == -1) {
      return -1;
    }
  }

  for (unsigned i = 1; i < end_time.size(); i++) {
    if (end_time[i] < answer && onDutyStaff[i].getEnergyLevel() > 0) {
      answer = end_time[i];
    }
  }
  return answer;
}
