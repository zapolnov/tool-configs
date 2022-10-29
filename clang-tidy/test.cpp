// clang-tidy playground

namespace sample_namespace{

int sample_global_variable;
int var;
const int global_constant = 19;

enum sample_enum{
	item,
	item1,
	item_2,
};

class abstract_class{
public:
	virtual void pure_virtual_func() = 0;
};

class sample_class{
	int sample_member_variable;
	int var;

	static const int const_var = 10;

	int func(int sample_param){
		return 0;
	}

	virtual int virt_func(){
		int local_var;
		return 10;
	}
public:
};

struct sample_struct{

};

class derived_class : public sample_class {
public:
	int virt_func()override{
		int* ptr = nullptr;
		return 20;
	}
};

template <typename param_type, int int_param, template <class, class> class param_templ>
class sample_template{

};

using sample_alias = derived_class;

// typedef derived_class sample_typedef;

union sample_union{
};


}
