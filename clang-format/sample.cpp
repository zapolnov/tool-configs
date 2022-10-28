#include <algorithm>
#include <cmath>
#include <utki/config.hpp>
#include <morda/widgets/button/push_button.hpp>
#include "some_file.hpp"
#include "some_dir/subdir/some_file.cxx"
#include "sample.hpp"
#include "../../some/parent/dir/some_file.h"
#include <iostream>

/**
 * @brief sample class a1.
 */
class sample_class_a1
{
	int a;

public:
	sample_class_a1(int a) :a(a){}
};

class sample_class_a2 : public sample_class_a1
{};

class sample_class_b : public sample_class_a1, private sample_sssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
{};

class sample_class_c :
public sample_class_a1, public sample_class_a2
{
public:
	int a;//some comment
	int b;

	sample_class_c(int a, int b, int ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc) :
		sample_class_a1(a),
		a(a),
		b(b)
	{}

    void func(int a, int b, int cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc)
	{
		int w = cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc + cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc + a;
		
		int wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww = cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc + cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc + a;

		std::cout //
		 << "printing values of different variables passed in as arguments to this function" << std::endl << "the first one would be:" <<std::endl
		<<"a = " << a << std::endl;

		std::cout 
		 << "printing values of different variables passed in as arguments to this function" << std::endl << "the first one would be:" <<std::endl
		<<"a = " << a << std::endl;
	}

	typename std::conditional<
	Is_const, const typename C::value_type, typename C::value_type>::type& operator*() noexcept
                {
                        return *this->iter_stack.back();
                }
};

void func()
{
auto out = utki::linq(std::move(in)).select([](auto v) {
auto r = std::make_pair(std::move(v.second), 13.4f);
tst::check(v.second.empty(), SL);
return r;
}).get();
}
