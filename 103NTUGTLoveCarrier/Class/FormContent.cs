using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NTUGTLoveCarrier.Class
{
    public class FormContent
    {
        public int Date { get; private set; }
        public int Class { get; private set; }
        public int Team { get; private set; }
        public string TeamMemberName { get; private set; }
        public int Song { get; private set; }
        public string SongName { get; private set; }
        public string Category { get; private set; }
        public string Place { get; private set; }
        public string ClassName { get; private set; }
        public int GeneralLesson { get; private set; }
        public string Name { get; private set; }
        public string DepartGrade { get; private set; }
        public string Phone { get; private set; }
        public string Email { get; private set; }
        public string SentName { get; private set; }
        public string SentDepartGrade { get; private set; }
        public string SentPhone { get; private set; }
        public string SentEmail { get; private set; }
        public int PayDay { get; private set; }
        public string SpecialRequest { get; private set; }
        public string Remark { get; private set; }
        public int Ispaid { get; private set; }

        public FormContent(int date, int _class, int team, string teamMemberName, int song, string songName, string category, string place, string className, int generalLesson, string name, string departGrade, string phone, string email, string sentName, string sentDepartGrade, string sentPhone, string sentEmail, int payDay, string specialRequest, string remark, int ispaid)
        {
            Date = date;
            Class = _class;
            Team = team;
            TeamMemberName = teamMemberName;
            Song = song;
            SongName = songName;
            Category = category;
            Place = place;
            ClassName = className;
            GeneralLesson = generalLesson;
            Name = name;
            DepartGrade = departGrade;
            Phone = phone;
            Email = email;
            SentName = sentName;
            SentDepartGrade = sentDepartGrade;
            SentPhone = sentPhone;
            SentEmail = sentEmail;
            PayDay = payDay;
            SpecialRequest = specialRequest;
            Remark = remark;
            Ispaid = ispaid;
        }

        public FormContent() { }

    }
}