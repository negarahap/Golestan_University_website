%negar_hosseinalipour
%981813062
txt_student=readmatrix("stu.txt");
txt_ins=readmatrix("ins.txt");
txt_emp=readmatrix("emp.txt");
txt_course=readmatrix("course.txt");
%txt_course=readtable('course.txt','format','%s%f');
lessons=["analys";"matlab";"algorithm";"database";"project"];
%convert table to matrix each  column
%txt_course_vahed=txt_course.Var2;
%txt_course_coursename=txt_course.Var1;

disp("*به سامانه گلستان خوش‌آمدید*");

login=input("  دانشجو=1;استاد=2;کارمند=3\n");


[n, m]=size(txt_student);%n= satr , m =soton
[a, s]=size(txt_ins);
[p, q]=size(txt_emp);



%---------------------------کارمند----------------------------------------

%for login by employee
if login==3
  check=0;
  namekarbar=input("نام کاربری:");
  for i=1:1:p
    if txt_emp(i,1)==namekarbar
        check=1;
        ramz_karmand=input("رمز:");
          if txt_emp(i,2)==ramz_karmand
              %نام دروس 
             choice=menu('courses:','1_analys','2_matlab','3_algorithm','4_database','5_project_cs');
             ask_to_change=menu('آیامیخواهی تعداد واحد درس را تغییر دهید؟','بله','خیر');
             if ask_to_change==1
                 new_vahed=input("تعداد واحد جدید درس را وارد کنید :");

                 %تعداد واحد جدید را جایگزین قبلی کند.
                 txt_course(1,choice)=new_vahed;
                 %جایگزین کردن واحد تغییر یافته درس
                 writematrix(txt_course,'course.txt');
                 %txt_course
                 
             else
                 fprintf("خروج");
             end


          else
            fprintf("رمز اشتباه میباشد!");
          end

    end 
 end 
if check==0
  fprintf("نام کاربری اشتباه میباشد");

end
end


%-----------------------student--------------------------------------------
%for login by student
zarbdar_zarib=0;
sum_numbers_ba_zarib=0;
vahed=0;
if login==1
  namekarbar=input("نام کاربری:");
  check=0;
  for i=1:1:n
    if txt_student(i,1)==namekarbar
      numberof_stu_column=i;
      check=1;
        ramz_stu=input("رمز:");
          if txt_student(i,2)==ramz_stu
             choice=menu('choose a method:','1_analys','2_matlab','3_algorithm','4_database','5_project_cs','report');
             %age nomre daneshjo baraye darse entekhabi sabt shode bod
             %neshoon mide
                 if choice~=6
                     if ~isnan(txt_student(numberof_stu_column,choice+2))
                        grade_of_lesson=txt_student(numberof_stu_column,choice+2);
                        ask_more=menu(sprintf('نمره ی شما : %f',grade_of_lesson),'اطلاعات بیشتر:','خروج');
                        if ask_more==1
                            avg_of_grade=mean(txt_student(:,choice+2));
                            max__of_grade=max(txt_student(:,choice+2));
                            min_of_grade=min(txt_student(:,choice+2));
                            fprintf('میانگین درس : %f\n',avg_of_grade);
                            fprintf('بیشترین نمره : %f\n',max__of_grade);
                            fprintf('کمترین نمره : %f\n',min_of_grade);
                        else
                            fprintf('درخواستی ندارم_خروج')
                        end
                     
                    else
                        disp("نمره ی شما ثبت نشده است")

                    end


                 else 
                     %کارنامه
                    w=1;
                    while w<=m-2
                        if ~isnan(txt_student(numberof_stu_column,w+2))
                            course_coursename=(lessons(w));
                            course_coursegrade=txt_student(numberof_stu_column,w+2);
                            vahed=vahed+txt_course(w);
                            zarbdar_zarib=txt_student(numberof_stu_column,w+2)*txt_course(w);
                            sum_numbers_ba_zarib=sum_numbers_ba_zarib+zarbdar_zarib;
                            fprintf('نام درس : %s نمره : %d\n',course_coursename,course_coursegrade);
                            w=w+1;
                        else
                            w=w+1;
                        end

                    end
                    fprintf('معدل : %f\n',rdivide(sum_numbers_ba_zarib,vahed));
                    %txt_course
                    
                 end

          else
            fprintf("رمز وارد شده اشتباه است");
          end
    end
  end
  if check==0
    fprintf("نام کاربری موجود نمیباشد")
  end
end

%-----------------------استاد---------------------------------------------

%for login by instructor


if login==2
  check=0;
  namekarbar=input("نام کاربری:");
  for i=1:1:a
    if txt_ins(i,1)==namekarbar
        check=1;
        ramz_inst=input("رمز:");
          if txt_ins(i,2)==ramz_inst
             choice=menu('courses:','1_analys','2_matlab','3_algorithm','4_database','5_project_cs');
             %چک کردن تهی بودن نمره یکی از دانشجو ها چون در این صورت نمره
             %تمام دانشجو ها وارد نشده است
                 if ~isnan(txt_student(1,choice+2))
                    for j=1:1:n
                        fprintf('شماره دانشجویی:  %d نمره : %d\n ',txt_student(j,1),txt_student(j,choice+2));
                    end
                    new_grades_calculates=nomre(txt_student,choice);
                    ask_to_change=menu('آیا مایل به تغییر نمرات هستید؟','بله','خیر');
                       
                     if ask_to_change==1
                             
                            for j=1:1:n
                                fprintf('%d\n',txt_student(j,1))
                                register_grades=input("نمره ی دانشجو وارد شود:\n");
                                txt_student(j,choice+2)=register_grades;
                             end
                             
                             %تعویض ماتریس با نمرات قدیم و ماتریس با نمرات جدید
                              new_txt_student=txt_student;
                              writematrix(new_txt_student,'stu.txt');
                              %new_txt_student
                             
                              %محاسبه ی میانگین و کمترین و بیشرین نمره های جدید وارد
                              %شده در فایل متنی
                              new_grades_calculates=nomre(new_txt_student,choice);
                      else
                            fprintf("خروج");
                      end                 

                 else

                     for j=1:1:n
                         %چاپ شماره دانشجو ها به ترتیب
                        fprintf('%d\n',txt_student(j,1))
                        register_grades=input("نمره ی دانشجو وارد شود:\n");
                        %نمره ی جدید جایگزین نمره ی قبلی شود 
                        txt_student(j,choice+2)=register_grades;
                     end
                     
                     %تعویض ماتریس با نمرات قدیم و ماتریس با نمرات جدید
                     new_txt_student=txt_student;
                     writematrix(new_txt_student,'stu.txt');
                     %new_txt_student
                    
                     %محاسبه ی میانگین و کمترین و بیشرین نمره های جدید وارد
                     %شده در فایل متنی
                     %با فراخوانی تابع محاسبه با توجه به نمرات جدید
                     %(ماترس ، شماره ستون درس)
                     new_grades_calculates=nomre(new_txt_student,choice);

                 end
          
           
             
          else
            fprintf("رمزکاربری اشتباه است !!");
   
          end
    end
  end
if check==0
  fprintf("نام کاربری اشتباه است!");
end
end

%_________________________________________________________________________
function g=nomre(n,c)
    g=n;
    g(:,1:2)=[];
    %میانگین
    avg_grade_stu=mean(g(:,c));
    %ماکسیمم
    max_grade_course=max(g(:,c));
    %مینیمم
    min_grade_course=min(g(:,c));
    fprintf('میانگین نمره درس : %f\n',avg_grade_stu);
    fprintf('ماکسیمم نمره درس : %f\n',max_grade_course);
    fprintf('مینیمم نمره درس : %f\n',min_grade_course);
end
